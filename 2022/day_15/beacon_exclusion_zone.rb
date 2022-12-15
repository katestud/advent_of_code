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
    read_file.length
  end

  private

  def read_file
    File.readlines(@file_name, chomp: true)
  end

end
