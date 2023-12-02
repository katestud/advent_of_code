require_relative "../../src/toolkit"

class CubeConundrum

  # The Elf would first like to know which games would have been possible if the bag contained only 12 red cubes, 13 green cubes, and 14 blue cubes?

  # Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green

  def initialize(file_name = "input.txt")
    @input = File.readlines(file_name, chomp: true)
  end

  def execute_one
    @input.map do |game|
      split_game(game)
    end.sum
  end

  def execute_two
    @input.length
  end

  def split_game(line)
    identifier, instructions = line.split(": ")
    id = identifier.split(" ").last.to_i

    red = instructions.scan(/\d{2,}\sred/)
    green = instructions.scan(/\d{2,}\sgreen/)
    blue = instructions.scan(/\d{2,}\sblue/)

    return 0 if red.any? { |match| match.to_i > 12 }
    return 0 if green.any? { |match| match.to_i > 13 }
    return 0 if blue.any? { |match| match.to_i > 14 }

    id
  end
end
