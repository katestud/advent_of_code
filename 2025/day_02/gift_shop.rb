require_relative "../../src/toolkit"

class GiftShop

# Since the young Elf was just doing silly patterns, you can find the invalid IDs by looking for any ID which is made only of some sequence of digits repeated twice. So, 55 (5 twice), 6464 (64 twice), and 123123 (123 twice) would all be invalid IDs.
#
#11-22 has two invalid IDs, 11 and 22.
# 95-115 has one invalid ID, 99.
# 998-1012 has one invalid ID, 1010.
# 1188511880-1188511890 has one invalid ID, 1188511885.
# 222220-222224 has one invalid ID, 222222.
# 1698522-1698528 contains no invalid IDs.
# 446443-446449 has one invalid ID, 446446.
# 38593856-38593862 has one invalid ID, 38593859.
# The rest of the ranges contain no invalid IDs.

  def initialize(file_name = "input.txt")
    @input = File.read(file_name, chomp: true).split(",")
  end

  def execute_one
    sum = 0
    @input.each do |range|
      b, e = range.split("-").map(&:to_i)
      (b..e).to_a.each do |val|
        str_val = val.to_s
        length = str_val.length
        next unless  length % 2 == 0
        next unless str_val[0, length / 2] == str_val[length / 2, length]
        sum += val
      end
    end
    sum
  end

  def execute_two
    @input.length
  end
end
