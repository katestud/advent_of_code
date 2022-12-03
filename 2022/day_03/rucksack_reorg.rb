class RucksackReorg

  LETTERS = ("a".."z").to_a + ("A".."Z").to_a

  def initialize(file_name = "input.txt")
    @file_name = file_name
  end

  # The first rucksack contains the items vJrwpWtwJgWrhcsFMMfFFhFp, which means its first compartment contains the items vJrwpWtwJgWr, while the second compartment contains the items hcsFMMfFFhFp. The only item type that appears in both compartments is lowercase p.

  def execute_one
    weight = 0
    read_file.each do |rucksack|
      first, second = rucksack.chars.each_slice(rucksack.size/2).to_a
      shared = (first & second).first
      weight += LETTERS.index(shared) + 1
    end
    weight
  end

  def execute_two
    weight = 0
    read_file.each_slice(3) do |group|
      first, second, third = group.map(&:chars)
      badge = (first & second & third).first
      weight += LETTERS.index(badge) + 1
    end
    weight
  end

  private

  def read_file
    File.readlines(@file_name, chomp: true)
  end

end
