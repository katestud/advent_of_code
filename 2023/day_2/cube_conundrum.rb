require_relative "../../src/toolkit"

class CubeConundrum

  # Example input line:
  # Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green

  def initialize(file_name = "input.txt")
    @input = File.readlines(file_name, chomp: true)
  end

  # The Elf would first like to know which games would have been possible if the bag contained only 12 red cubes, 13 green cubes, and 14 blue cubes?
  def execute_one
    @input.map do |game|
      valid_game_id(game)
    end.sum
  end

  # The power of a set of cubes is equal to the numbers of red, green, and blue cubes multiplied together. The power of the minimum set of cubes in game 1 is 48. In games 2-5 it was 12, 1560, 630, and 36, respectively. Adding up these five powers produces the sum 2286.
  def execute_two
    map = @input.map do |game|
      game_power(game)
    end.sum
  end

  def valid_game_id(line)
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

  def game_power(line)
    _, instructions = line.split(": ")

    [
      instructions.scan(/\d+\sred/).map(&:to_i).max,
      instructions.scan(/\d+\sgreen/).map(&:to_i).max,
      instructions.scan(/\d+\sblue/).map(&:to_i).max
    ].compact.reduce(:*)
  end
end
