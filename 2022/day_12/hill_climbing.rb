class HillClimbing

  def initialize(file_name = "input.txt")
    @file_name = file_name
    @grid = build_grid
  end

  def execute_one
    find_shortest_path(@grid, @start_pos, @goal_pos).length - 1
  end

  # Find the shortest path from start to end, given a grid of characters
  def find_shortest_path(grid, start_coords, end_coords)
    # Build a queue of paths
    queue = [[start_coords]]

    # Keep track of visited positions
    visited = Set.new

    # Keep looping until the queue is empty
    until queue.empty?
      # Take the first path from the queue
      path = queue.shift

      # Grab the last position from the path
      current_pos = path.last

      # If we've reached the end, return the path
      if current_pos == end_coords
        return path
      end

      # Otherwise, get new candidate positions to explore
      candidates = find_next_available_positions(current_pos[0], current_pos[1])

      # Loop through each candidate
      candidates.each do |candidate|
        # Copy the path
        new_path = path.dup

        # Add the candidate to the path
        new_path << candidate

        # If we haven't already visited this candidate, add it to the queue
        unless visited.include?(candidate)
          queue << new_path
          visited << candidate
        end
      end
    end

    # Return nil if no path is found
    nil
  end

  def execute_two
    @grid.length
  end

  private

  def find_next_available_positions(x, y)
    char = @grid[x][y]
    options = []
    options << [x - 1, y] if x > 0
    options << [x + 1, y] if x < @grid.length - 1
    options << [x, y - 1] if y > 0
    options << [x, y + 1] if y < @grid[0].length - 1
    position_options = options.select do |pos|
      @grid.dig(*pos).ord - char.ord  <= 1
    end
  end

  def build_grid
    File.readlines(@file_name, chomp: true).map.with_index do |line, index|
      chars = line.chars
      if chars.include?("S")
        char_index = chars.index("S")
        @start_pos = [index, char_index]
        chars[char_index] = "a"
      end
      if chars.include?("E")
        char_index = chars.index("E")
        @goal_pos = [index, char_index]
        chars[char_index] = "z"
      end
      chars
    end
  end
end
