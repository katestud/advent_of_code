class Rock
  def initialize(grid, settled_coordinates)
    @grid = grid
    set_starting_position(settled_coordinates)
  end

  def attempt_move(settled_coordinates, direction)
    case direction
    when "<"
      move_left(settled_coordinates)
    when ">"
      move_right(settled_coordinates)
    when "down"
      move_down(settled_coordinates)
    else
      raise "no direction"
    end
  end

  def final_resting_coords
    find_potential_rock_coords(@top_coordinates)
  end

  private

  def set_starting_position(settled_coordinates)
    height = settled_coordinates.max_by { |coord| coord[0] }.first
    @top_coordinates = [height + @grid.length + 3, 2]
  end

  def move_left(settled_coordinates)
    return @top_coordinates unless @top_coordinates[1] > 0
    potential = [@top_coordinates[0], @top_coordinates[1] - 1]
    if can_move?(potential, settled_coordinates)
      @top_coordinates = potential
    else
      @top_coordinates
    end
  end

  def move_right(settled_coordinates)
    return @top_coordinates unless @top_coordinates[1] < 7 - @grid[0].length
    potential = [@top_coordinates[0], @top_coordinates[1] + 1]
    if can_move?(potential, settled_coordinates)
      @top_coordinates = potential
    else
      @top_coordinates
    end
  end

  def move_down(settled_coordinates)
    potential = [@top_coordinates[0] - 1, @top_coordinates[1]]
    if can_move?(potential, settled_coordinates)
      @top_coordinates = potential
    else
      false
    end
  end

  def can_move?(potential, settled)
    potential_rock_coords = find_potential_rock_coords(potential)
    potential_rock_coords.none? do |coord|
      settled.include?(coord)
    end
  end

  def find_potential_rock_coords(potential_coords)
    coords = []
    @grid.each_with_index do |row, row_index|
      row.each_with_index do |column, column_index|
        next unless column == 1
        coords << [potential_coords[0] - row_index, potential_coords[1] + column_index]
      end
    end
    coords
  end

end

class PyroclasticFlow
  def initialize(file_name = "input.txt")
    @rock_grids = build_rocks
    @all_rock_coords = Set.new([[0, 0], [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0,6]])
    @file_name = file_name
  end

  def execute_one
    winds = read_file.cycle(1000).to_a
    rock_grids = @rock_grids.cycle(405).to_a.take(2022)
    rock_grids.each do |rock_grid|
      rock = Rock.new(rock_grid, @all_rock_coords)
      wind = winds.shift
      rock.attempt_move(@all_rock_coords, wind)
      while rock.attempt_move(@all_rock_coords, "down")
        wind = winds.shift
        rock.attempt_move(@all_rock_coords, wind)
      end
      @all_rock_coords += rock.final_resting_coords
    end
    @all_rock_coords.max_by { |coord| coord[0] }.first
  end

  def execute_two
    read_file.length
  end

  private

  def read_file
    File.read(@file_name, chomp: true).sub("\n", "").chars
  end

  def build_rocks
    rocks = [
      [[1, 1, 1, 1]],
      [[0, 1, 0], [1, 1, 1], [0, 1, 0]],
      [[0, 0, 1], [0, 0, 1], [1, 1, 1]],
      [[1], [1], [1], [1]],
      [[1, 1], [1, 1]]
    ]
  end

end
