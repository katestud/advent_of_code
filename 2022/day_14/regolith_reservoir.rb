class RegolithReservoir

  def initialize(file_name = "input.txt")
    @file_name = file_name
    @rock_coords = build_rock_coords
    @left_x = @rock_coords.map(&:first).min
    @right_x = @rock_coords.map(&:first).max
    @bottom_y = @rock_coords.map(&:last).max
    @sand_coords = Set.new
  end

  def execute_one
    drop_sand
    @sand_coords.count
  end

  def execute_two
    read_file.length
  end

  private

  def read_file
    File.readlines(@file_name, chomp: true)
  end

  def drop_sand
    current = [500, 0]
    while current.first >= @left_x && current.first <= @right_x && current.last <= @bottom_y
      if new_coords = attempt_to_move_down(current)
        current = new_coords
      elsif new_coords = attempt_to_move_left_down(current)
        current = new_coords
      elsif new_coords = attempt_to_move_right_down(current)
        current = new_coords
      else
        @sand_coords.add(current)
        current = [500, 0]
      end
    end
  end

  # 498,4 -> 498,6 -> 496,6
  # 503,4 -> 502,4 -> 502,9 -> 494,9

  def build_rock_coords
    rock_coords = Set.new
    read_file.each do |line|
      instructions = line.split("->")
      start = instructions.shift.split(",").map(&:to_i)
      rock_coords.add(start)
      current = start
      instructions.each do |instruction|
        next_coord = instruction.split(",").map(&:to_i)
        if next_coord.first == current.first
          ys = [current.last, next_coord.last].sort
          Range.new(*ys).each do |y|
            rock_coords.add [current.first, y]
          end
        else
          xs = [current.first, next_coord.first].sort
          Range.new(*xs).each do |x|
            rock_coords.add [x, current.last]
          end
        end
        current = next_coord
      end
    end
    rock_coords
  end

  def position_taken?(coords)
    @rock_coords.include?(coords) || @sand_coords.include?(coords)
  end

  def attempt_to_move_down(coords)
    new_coords = [coords.first, coords.last + 1]
    position_taken?(new_coords) ? false : new_coords
  end

  def attempt_to_move_left_down(coords)
    new_coords = [coords.first - 1, coords.last + 1]
    position_taken?(new_coords) ? false : new_coords
  end

  def attempt_to_move_right_down(coords)
    new_coords = [coords.first + 1, coords.last + 1]
    position_taken?(new_coords) ? false : new_coords
  end
end
