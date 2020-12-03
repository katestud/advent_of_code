class Trajectory

  @hill_grid : Array(String)

  def initialize(input_file = "input.txt")
    @hill_grid = File.read_lines(input_file)
  end

  def traverse(right = 3, skip_rows = false)
    position = 0
    tree_count = 0
    @hill_grid.each_with_index do |row, row_index|
      next if skip_rows && row_index.odd?
      adjusted_position = position % row.size
      tree_count += 1 if row[adjusted_position] == '#'
      position += right
    end
    tree_count
  end

  # Determine the number of trees you would encounter if, for each of the following slopes, you start at the top-left corner and traverse the map all the way to the bottom:

  # Right 1, down 1.
  # Right 3, down 1. (This is the slope you already checked.)
  # Right 5, down 1.
  # Right 7, down 1.
  # Right 1, down 2.

  def optimize
    down1_product = [1, 3, 5, 7].reduce(1) { |acc, i| acc * traverse(i) }
    down1_product * traverse(1, true)
  end
end

puts Trajectory.new.traverse
puts Trajectory.new.optimize
