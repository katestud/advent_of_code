class RopeBridge

  def initialize(file_name = "input.txt")
    @file_name = file_name
    @starting_coords = [0, 0]
    @visited_coords = Set.new([@starting_coords])
  end


  def execute_one
    head_coords = @starting_coords.dup
    tail_coords = @starting_coords.dup
    read_file.each do |instruction|
      # puts instruction
      dir, times = instruction.split
      times.to_i.times.each do
        case dir
        when "R"
          head_coords = [head_coords[0] + 1, head_coords[1]]
        when "L"
          head_coords = [head_coords[0] - 1, head_coords[1]]
        when "U"
          head_coords = [head_coords[0], head_coords[1] + 1]
        when "D"
          head_coords = [head_coords[0], head_coords[1] - 1]
        end
        tail_coords = new_tail_coords(head_coords, tail_coords)
        # puts "new tail coords: #{tail_coords}"
        @visited_coords << tail_coords
      end
    end
    # puts @visited_coords
    @visited_coords.count
  end

  def execute_two
    read_file.length
  end

  private

  def read_file
    File.readlines(@file_name, chomp: true)
  end


  # If the head is ever two steps directly up, down, left, or right from the tail, the tail must also move one step in that direction so it remains close enough:

  # Otherwise, if the head and tail aren't touching and aren't in the same row or column, the tail always moves one step diagonally to keep up:

  def new_tail_coords(head_coords, tail_coords)
    return tail_coords if touching?(head_coords, tail_coords)

    if head_coords[0] == tail_coords[0]
      if head_coords[1] > tail_coords[1]
        [tail_coords[0], tail_coords[1] + 1]
      else
        [tail_coords[0], tail_coords[1] - 1]
      end
    elsif head_coords[1] == tail_coords[1]
      if head_coords[0] > tail_coords[0]
        [tail_coords[0] + 1, tail_coords[1]]
      else
        [tail_coords[0] - 1, tail_coords[1]]
      end
    else
      new_x = head_coords[0] > tail_coords[0] ? tail_coords[0] + 1 : tail_coords[0] - 1
      new_y = head_coords[1] > tail_coords[1] ? tail_coords[1] + 1 : tail_coords[1] - 1
      [new_x, new_y]
    end
  end

  def touching?(head_coords, tail_coords)
    # touching diagonally
    # puts "head coords: #{head_coords.inspect}"
    # puts "tail coords: #{tail_coords.inspect}"
    return true if head_coords == tail_coords

    return true if (head_coords[0] - tail_coords[0]).abs <= 1 && (head_coords[1] - tail_coords[1]).abs <= 1
    false
  end
end


# [3, 4] and [2,2] should become [3, 3]
# [1, 0] and [0,2]  should become [1, 1]

# if x is higher, x should increase by one
# if y is higher, y should increase by one
# end
