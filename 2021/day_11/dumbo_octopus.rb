class DumboOctopus

  def initialize(file_name = "input.txt")
    @grid = File.readlines(file_name, chomp: true).map {|line| line.chars.map(&:to_i) }
    @flashes = 0
  end

  def execute_one
    100.times do
      # First, the energy level of each octopus increases by 1.
      increment_grid
      flash_octopi
    end
    @flashes
  end

  def execute_two
    step = 0
    1000.times do |i|
      if @grid.all? {|row| row.all? {|cell| cell == 0 } }
        step = i
        break
      end
      # First, the energy level of each octopus increases by 1.
      increment_grid
      flash_octopi
    end
    step
  end

  private

  def increment_grid
    @grid.each_with_index do |row, row_index|
      row.each_with_index do |cell, cell_index|
        @grid[row_index][cell_index] += 1
      end
    end
  end

  def flash_octopi
    # Then, any octopus with an energy level greater than 9 flashes. This increases the energy level of all adjacent octopuses by 1, including octopuses that are diagonally adjacent. If this causes an octopus to have an energy level greater than 9, it also flashes. This process continues as long as new octopuses keep having their energy level increased beyond 9. (An octopus can only flash at most once per step.)
    while @grid.any? {|row| row.any? {|cell| cell > 9 } }
      @grid.each_with_index do |row, row_index|
        row.each_with_index do |cell, cell_index|
          next unless cell == 10
          neighbors(row_index, cell_index).each do |neighbor|
            if (1..9).cover?(@grid[neighbor[0]][neighbor[1]])
              @grid[neighbor[0]][neighbor[1]] += 1
            end
          end
          # Finally, any octopus that flashed during this step has its energy level set to 0, as it used all of its energy to flash.
          @grid[row_index][cell_index] = 0
          @flashes += 1
        end
      end
    end
  end

  def neighbors(row_index, cell_index)
    [
      [row_index - 1, cell_index - 1],
      [row_index - 1, cell_index],
      [row_index - 1, cell_index + 1],
      [row_index, cell_index - 1],
      [row_index, cell_index + 1],
      [row_index + 1, cell_index - 1],
      [row_index + 1, cell_index],
      [row_index + 1, cell_index + 1]
    ].select { |neighbors| neighbors.all? { |n| (0..9).cover?(n) } }
  end

end
