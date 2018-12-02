# For example, if you see the following box IDs:

# abcdef contains no letters that appear exactly two or three times.
# bababc contains two a and three b, so it counts for both.
# abbcde contains two b, but no letter appears exactly three times.
# abcccd contains three c, but no letter appears exactly two times.
# aabcdd contains two a and two d, but it only counts once.
# abcdee contains two e.
# ababab contains three a and three b, but it only counts once.
# Of these box IDs, four of them contain a letter which appears exactly twice, and three of them contain a letter which appears exactly three times. Multiplying these together produces a checksum of 4 * 3 = 12.

# What is the checksum for your list of box IDs?


input = File.read("input.txt").split("\n")
exactly_two_count = 0
exactly_three_count = 0

input.each do |box_id|

    char_count = {} of Char => Int32

    box_id.chars.each do |char|
        count = char_count[char]? ? char_count[char] : 0
        char_count[char] = count + 1
    end

    exactly_two_count += 1 if char_count.values.includes?(2)
    exactly_three_count += 1 if char_count.values.includes?(3)

end

puts exactly_three_count * exactly_two_count