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
      dir, times = instruction.split
      times.to_i.times.each do
        head_coords = move_in_direction(head_coords, dir)
        tail_coords = move_tail(head_coords, tail_coords)
        @visited_coords << tail_coords
      end
    end
    @visited_coords.count
  end

  def execute_two
    head_coords = @starting_coords.dup
    tails_coords = 9.times.map { @starting_coords.dup }
    read_file.each do |instruction|
      dir, times = instruction.split
      times.to_i.times.each do
        head_coords = move_in_direction(head_coords, dir)
        prev_tail_coords = head_coords.dup

        tails_coords = tails_coords.map do |tail_coords|
          prev_tail_coords = move_tail(prev_tail_coords, tail_coords)
        end

        @visited_coords << tails_coords.last
      end
    end
    @visited_coords.count
  end

  private

  def read_file
    File.readlines(@file_name, chomp: true)
  end

  def move_in_direction(coords, dir)
    case dir
    when "R"
      [coords[0] + 1, coords[1]]
    when "L"
      [coords[0] - 1, coords[1]]
    when "U"
      [coords[0], coords[1] + 1]
    when "D"
      [coords[0], coords[1] - 1]
    end
  end


  # If the head is ever two steps directly up, down, left, or right from the tail, the tail must also move one step in that direction so it remains close enough:

  # Otherwise, if the head and tail aren't touching and aren't in the same row or column, the tail always moves one step diagonally to keep up:

  def move_tail(head_coords, tail_coords)
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
    # Overlaid on top of each other
    return true if head_coords == tail_coords

    # One or both of the coordinates are the same, or within 1 of each other
    return true if (head_coords[0] - tail_coords[0]).abs <= 1 && (head_coords[1] - tail_coords[1]).abs <= 1
    false
  end
end
