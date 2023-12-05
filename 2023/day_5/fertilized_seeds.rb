require_relative "../../src/toolkit"

class FertilizedSeeds

  def initialize(file_name = "input.txt")
    @input = read_file_into_batches(file_name)
    @seeds = @input.shift.first.split[1..-1].map(&:to_i)
    @offset_from_start_of_range, @convertible_ranges = generate_maps
  end

  def execute_one
    find_smallest_location(@seeds)
  end

  def execute_two
    current_ranges = @seeds.each_slice(2).map do |slice|
      slice[0]...slice[0]+slice[1]
    end
    @convertible_ranges.each_with_index do |instruction_round, index|
      new_ranges = []
      current_ranges.each do |range|
        current_range = range
        while current_range
          current_range = find_overlapping_ranges(instruction_round, index, new_ranges, current_range)
        end

      end
      current_ranges = new_ranges.dup
    end

    current_ranges.map(&:begin).min
  end

  def find_overlapping_ranges(instruction_round, index, new_ranges, range)
    fully_contained_range = instruction_round.detect do |map_range|
      map_range.cover?(range.begin) && map_range.cover?(range.end)
    end
    if fully_contained_range
      offset = @offset_from_start_of_range[index][fully_contained_range.begin]
      new_ranges << (range.begin-offset...range.end-offset)
      return nil
    end

    beginning_of_range_included = instruction_round.detect do |map_range|
      map_range.cover?(range.begin)
    end
    if beginning_of_range_included
      offset = @offset_from_start_of_range[index][beginning_of_range_included.begin]
      new_ranges << (range.begin-offset...beginning_of_range_included.end-offset)
      return beginning_of_range_included.end...range.end
    end

    end_of_range_included = instruction_round.detect do |map_range|
      map_range.cover?(range.end)
    end
    if end_of_range_included
      offset = @offset_from_start_of_range[index][end_of_range_included.begin]
      new_ranges << (end_of_range_included.begin-offset...range.end-offset)
      return range.begin...end_of_range_included.begin-1
    end

    new_ranges << range
    return nil
  end

  def generate_maps
    maps = []
    range_groups = []
    @input.each do |group|
      group.shift
      map = {}
      ranges = []
      group.each do |line|
        dest, source, length = line.split.map(&:to_i)
        map[source] = source - dest
        ranges << (source...source+length)
      end
      maps << map
      range_groups << ranges
    end
    range_groups.map! { |range| range.sort_by(&:begin) }
    [maps, range_groups]
  end

  def find_smallest_location(seeds)
    min = nil
    range_length = @convertible_ranges.length
    seeds.each_with_index do |seed, seed_index|
      location = seed
      @convertible_ranges.each_with_index do |group, index|
        range = group.detect do |range|
          range.cover?(location)
        end
        if range
          offset = location - range.first
          new_location = location - @offset_from_start_of_range[index][range.first]
          location = new_location
        end
        if index == range_length - 1
          if min && location < min
            min = location
          elsif min.nil?
            min = location
          end
        end
      end
    end
    min
  end
end



