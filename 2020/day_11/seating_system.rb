# If a seat is empty (L) and there are no occupied seats adjacent to it, the seat becomes occupied.
# If a seat is occupied (#) and four or more seats adjacent to it are also occupied, the seat becomes empty.
# Otherwise, the seat's state does not change.

input = File.readlines("input.txt", chomp: true)

def run_seating_system(input)
  changed = false
  map = input.map.with_index do |line, line_index|
    start_line = [line_index - 1, 0].max
    end_line = [line_index + 1, input.length - 1].min
    surrounding_lines = input[start_line..end_line]
    line.each_char.map.with_index do |char, char_index|
      next char if char == "."
      start_char = [char_index - 1, 0].max
      end_char = [char_index + 1, line.length - 1].min
      surrounding_chars = surrounding_lines.map { |l| l[start_char..end_char] }.join
      if char == "L"
        if surrounding_chars.each_char.none? {|c| c == "#"}
          changed = true
          "#"
        else
          char
        end
      elsif char == "#"
        if surrounding_chars.count("#") >= 5
          changed = true
          "L"
        else
          char
        end
      end
    end.join
  end
  [changed, map]
end

changed = true
seating = input

while changed
  changed, seating = run_seating_system(seating)
end

puts "============="
puts seating
puts "============="

puts "Total occupied seats:"
puts seating.join.count("#")


def find_first_visible_seat(input, input_length, line_length, line_index, char_index, direction)
  case direction
  when :right
    return if char_index + 1 >= line_length
    seat = input[line_index][char_index + 1]
    seat == "." ? find_first_visible_seat(input, input_length, line_length, line_index, char_index + 1, direction) : seat
  when :left
    return if char_index <= 0
    seat = input[line_index][char_index - 1]
    seat == "." ? find_first_visible_seat(input, input_length, line_length, line_index, char_index - 1, direction) : seat
  when :up
    return if line_index <= 0
    seat = input[line_index -1][char_index]
    seat == "." ? find_first_visible_seat(input, input_length, line_length, line_index - 1, char_index, direction) : seat
  when :down
    return if line_index + 1 >= input_length
    seat = input[line_index + 1][char_index]
    seat == "." ? find_first_visible_seat(input, input_length, line_length, line_index + 1, char_index, direction) : seat
  when :upright
    return if line_index <= 0 || char_index + 1 >= line_length
    seat = input[line_index - 1][char_index + 1]
    seat == "." ? find_first_visible_seat(input, input_length, line_length, line_index - 1, char_index + 1, direction) : seat
  when :downright
    return if line_index + 1 >= input_length || char_index + 1 >= line_length
    seat = input[line_index + 1][char_index + 1]
    seat == "." ? find_first_visible_seat(input, input_length, line_length, line_index + 1, char_index + 1, direction) : seat
  when :upleft
    return if line_index <= 0 || char_index <= 0
    seat = input[line_index - 1][char_index - 1]
    seat == "." ? find_first_visible_seat(input, input_length, line_length, line_index - 1, char_index - 1, direction) : seat
  when :downleft
    return if line_index + 1 >= input_length || char_index - 1 < 0
    seat = input[line_index + 1][char_index - 1]
    seat == "." ? find_first_visible_seat(input, input_length, line_length, line_index + 1, char_index - 1, direction) : seat
  end
end


def run_realistic_seating_system(input)
  changed = false
  map = input.map.with_index do |line, line_index|
    line.each_char.map.with_index do |char, char_index|
      next char if char == "."

      visible_seats = %i(up down left right upleft upright downleft downright).map do |dir|
        find_first_visible_seat(input, input.length, line.length, line_index, char_index, dir)
      end


      if char == "L"
        if visible_seats.none? {|c| c == "#"}
          changed = true
          "#"
        else
          char
        end
      elsif char == "#"
        if visible_seats.count("#") >= 5
          changed = true
          "L"
        else
          char
        end
      end
    end.join
  end
  [changed, map]
end


changed = true
seating = input

while changed
  changed, seating = run_realistic_seating_system(seating)
end

puts "============="
puts seating
puts "============="

puts "Total occupied seats:"
puts seating.join.count("#")
