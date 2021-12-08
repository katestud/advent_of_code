class SevenSegment

  ZERO = "abcefg"
  ONE = "cf"
  TWO = "acdeg"
  THREE = "acdfg"
  FOUR = "bcdf"
  FIVE = "abdfg"
  SIX = "abdefg"
  SEVEN = "acf"
  EIGHT = "abcdefg"
  NINE = "abcdfg"

  def initialize(file_name = "input.txt")
    @file_name = file_name
  end

  def execute_one
    lengths = [ONE, FOUR, SEVEN, EIGHT].map(&:length)
    read_file.map do |line|
      line.last.split.count { |number| lengths.include?(number.length) }
    end.sum
  end

  def execute_two
    read_file.map do |line|
      nums = nums(line.first.split)
      line.last.split.map do |number|
        nums.index(number.chars.sort.join)
      end.join.to_i
    end.sum
  end

  private

  def read_file
    File.readlines(@file_name, chomp: true).map { |line| line.split(" | ") }
  end

  def nums(digits)
    char_map = {}
    one, seven, four, two_three_five_1, two_three_five_2, two_three_five_3, zero_six_nine_1, zero_six_nine_2, zero_six_nine_3, eight = digits.sort_by { |digit| digit.length }
    char_map["a"] = seven.delete(one)
    gs, es = [two_three_five_1, two_three_five_2, two_three_five_3].map do |two_three_five|
      two_three_five.delete(char_map["a"] + four)
    end.partition { |e| e.length == 1 }
    char_map["g"] = gs.first
    char_map["e"] = es.first.delete(char_map["g"])
    two = [two_three_five_1, two_three_five_2, two_three_five_3].detect { |i| i.include?(char_map["e"]) }
    char_map["b"] = eight.delete(two).delete(one)
    char_map["d"] = four.delete(one).delete(char_map["b"])
    char_map["f"] = eight.delete(two).delete(char_map["b"])
    char_map["c"] = one.delete(char_map["f"])

    nums = [ZERO, ONE, TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE].map do |number|
      number.split("").map { |digit| char_map[digit] }.sort.join
    end
  end

end
