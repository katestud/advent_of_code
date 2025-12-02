require_relative "../../src/toolkit"

class GiftShop

  def initialize(file_name = "input.txt")
    @input = File.read(file_name, chomp: true).split(",")
    @ids = @input
      .map { |line| line.split("-").map(&:to_i) }
      .map { |b, e| (b..e).to_a }
      .flatten
  end

  def execute_one
    sum = 0
    @ids.each do |val|
      sum += val if is_invalid?(val)
    end
    sum
  end

  def execute_two
    sum = 0
    @ids.each do |val|
      sum += val if is_invalid_two?(val)
    end
    sum
  end

  #11-22 has two invalid IDs, 11 and 22.
  # 95-115 has one invalid ID, 99.
  # 998-1012 has one invalid ID, 1010.
  # 1188511880-1188511890 has one invalid ID, 1188511885.
  # 222220-222224 has one invalid ID, 222222.
  # 1698522-1698528 contains no invalid IDs.
  # 446443-446449 has one invalid ID, 446446.
  # 38593856-38593862 has one invalid ID, 38593859.
  # The rest of the ranges contain no invalid IDs.

  def is_invalid?(id)
    str_id = id.to_s
    length = str_id.length
    return false unless  length % 2 == 0
    return false unless str_id[0, length / 2] == str_id[length / 2, length]
    true
  end

  # 11-22 still has two invalid IDs, 11 and 22.
  # 95-115 now has two invalid IDs, 99 and 111.
  # 998-1012 now has two invalid IDs, 999 and 1010.
  # 1188511880-1188511890 still has one invalid ID, 1188511885.
  # 222220-222224 still has one invalid ID, 222222.
  # 1698522-1698528 still contains no invalid IDs.
  # 446443-446449 still has one invalid ID, 446446.
  # 38593856-38593862 still has one invalid ID, 38593859.
  # 565653-565659 now has one invalid ID, 565656.
  # 824824821-824824827 now has one invalid ID, 824824824.
  # 2121212118-2121212124 now has one invalid ID, 2121212121.
  def is_invalid_two?(id)
    str_id = id.to_s
    length = str_id.length
    1.upto(length-1).each do |i|
      parts = str_id.scan(/.{1,#{i}}/)
      return true if parts.uniq.size == 1
    end
    false
  end
end
