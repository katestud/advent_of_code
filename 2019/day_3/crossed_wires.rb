require_relative "../../src/toolkit"

require "set"

class CrossedWires

  def initialize(file_name = "input.txt")
    @input = read_lines_with_separator(file_name)
    @origin = [0,0]
    @first_wire, @second_wire = @input
  end

  def execute_one
    @first_wire.length
    first_wire_seen = travel(@first_wire)
    second_wire_seen = travel(@second_wire)
    first_wire_seen.intersection(second_wire_seen).map do |pos|
      pos.sum(&:abs)
    end.min
  end

  def execute_two
    @input.length
  end

  private

  def travel(wire_instructions)
    last_pos = @origin.dup
    Set.new.tap do |seen|
      wire_instructions.each do |instruction|
        dir = instruction[0]
        dist = instruction[1..-1].to_i
        1.upto(dist) do |i|
          case dir
          when "R"
            next_last_pos = [last_pos[0], last_pos[1] + 1]
          when "L"
            next_last_pos = [last_pos[0], last_pos[1] - 1]
          when "U"
            next_last_pos = [last_pos[0] + 1, last_pos[1]]
          when "D"
            next_last_pos = [last_pos[0] - 1, last_pos[1]]
          end
          seen << next_last_pos
          last_pos = next_last_pos
        end
      end
    end
  end

end
