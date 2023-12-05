require_relative "../../src/toolkit"

class FertilizedSeeds

  def initialize(file_name = "input.txt")
    @input = read_file_into_batches(file_name)
    @seeds = @input.shift.first.split[1..-1].map(&:to_i)
    @maps, @ranges = generate_maps
  end

  def execute_one
    paths = {}
    @seeds.each do |seed|
      paths[seed] = []
      location = seed
      @ranges.each_with_index do |group, index|
        range = group.detect do |range|
          range.cover?(location)
        end
        if range
          offset = location - range.first
          new_location = @maps[index][range.first] + offset
          paths[seed] << new_location
          location = new_location
        else
          paths[seed] << location
        end
      end
    end
    paths.values.map(&:last).min
  end

  def execute_two
    @input.length
  end

  def generate_maps
    maps = []
    range_groups = []
    @input.each do |group|
      group.shift
      map = {}
      ranges = []
      group.each do |line|
        deststart, sourcestart, length = line.split.map(&:to_i)
        map[sourcestart] = deststart
        ranges << (sourcestart..sourcestart+length)
      end
      maps << map
      range_groups << ranges
    end
    [maps, range_groups]
  end
end



