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

# The boxes will have IDs which differ by exactly one character at the same position in both strings. For example, given the following box IDs:

# abcde
# fghij
# klmno
# pqrst
# fguij
# axcye
# wvxyz
# The IDs abcde and axcye are close, but they differ by two characters (the second and fourth). However, the IDs fghij and fguij differ by exactly one character, the third (h and u). Those must be the correct boxes.

input = File.read("input.txt").split("\n")

input.each_with_index do |box_id, index|
    dup_found = false

    input.each_with_index do |compared_box_id, compared_index|
        next if index == compared_index
        current_box_chars = box_id.chars
        compared_box_chars = compared_box_id.chars
        difference_count = 0
        current_box_chars.each_with_index do |char, char_index|
            unless compared_box_chars[char_index]?
                difference_count += 1
                next
            end
            if char != compared_box_chars[char_index]
                difference_count += 1 
                next
            end
        end
        if difference_count == 1
            puts box_id 
            puts compared_box_id 
            dup_found = true
            break
        end
    end
    break if dup_found

end