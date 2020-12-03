class Trajectory

  @hill_grid : Array(String)

  def initialize(input_file = "input.txt")
    @hill_grid = File.read_lines(input_file)
  end

  def traverse
    index = 0
    tree_count = 0
    @hill_grid.each do |row|
      adjusted_index = index % row.size
      tree_count += 1 if row[adjusted_index] == '#'
      index += 3
    end
    tree_count
  end
end

puts Trajectory.new.traverse
