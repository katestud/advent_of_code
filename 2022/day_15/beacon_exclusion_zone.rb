class BeaconExclusionZone

  def initialize(file_name = "input.txt", row)
    @file_name = file_name
    @row = row
    @beacons = Set.new
    @covered_positions = Set.new
  end

  # Sensor at x=2, y=18: closest beacon is at x=-2, y=15
  def execute_one
    read_file.each do |line|
      sensor_x, sensor_y, beacon_x, beacon_y = line.scan(/-?\d+/).map(&:to_i)
      @beacons.add([beacon_x, beacon_y])
      distance = (sensor_x - beacon_x).abs + (sensor_y - beacon_y).abs
      ydiff = (@row - sensor_y).abs
      available_x_diff = distance - ydiff
      (sensor_x - available_x_diff..sensor_x + available_x_diff).each do |x|
        @covered_positions.add([x, @row])
      end
    end
    (@covered_positions - @beacons).size
  end

  def execute_two
    coords_and_distances = read_file.each_with_object({}) do |line, hash|
      sensor_x, sensor_y, beacon_x, beacon_y = line.scan(/-?\d+/).map(&:to_i)
      distance = (sensor_x - beacon_x).abs + (sensor_y - beacon_y).abs
      hash[[sensor_x, sensor_y]] = distance
    end
    @row.times.each do |y|
      range1, range2 = generate_final_two_ranges(y, coords_and_distances)
      next if range1.cover?(range2.first) || range2.cover?(range1.first)
      smaller_range = range1.first < range2.first ? range1 : range2
      x = smaller_range.last + 1
      return x * 4000000 + y
    end
  end

  private

  def read_file
    File.readlines(@file_name, chomp: true)
  end

  def generate_final_two_ranges(y, sensors)
    ranges = []
    sensors.each do |(sensor_x, sensor_y), distance|
      ydiff = (y - sensor_y).abs
      available_x_diff = distance - ydiff
      next if available_x_diff < 0

      range = ([sensor_x - available_x_diff, 0].max..[sensor_x + available_x_diff, @row].min)

      ranges << range
    end

    ranges = ranges.sort_by { |range| range.first }
    while ranges.length > 2
      new_ranges = []
      ranges.each_slice(2) do |range1, range2|
        next new_ranges << range1 if range2.nil?
        if range1.cover?(range2.first) || range2.cover?(range1.first)
          new_range = ([range1.first, range2.first].min..[range1.last, range2.last].max)
          new_ranges << new_range
        else
          new_ranges << range1
          new_ranges << range2
        end
      end
      ranges = new_ranges
    end
    ranges
  end

end
