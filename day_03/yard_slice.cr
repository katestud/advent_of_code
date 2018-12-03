# A claim like #123 @ 3,2: 5x4 means that claim ID 123 specifies a rectangle 3 inches from the left edge, 2 inches from the top edge, 5 inches wide, and 4 inches tall. 
# Visually, it claims the square inches of fabric represented by # (and ignores the square inches of fabric represented by .)

input = File.read("test_input.txt").split("\n")

fabric = [Array.new(1000, "*")]
999.times { fabric <<  Array.new(1000, "*") }
x_count = 0

input.each do |claim|
    split_claim = claim.split(/[\s,x:]/)
    claim_id = split_claim[0]
    left = split_claim[2].to_i
    top = split_claim[3].to_i
    width = split_claim[5].to_i
    height = split_claim[6].to_i
    height.times do |h|
        row = fabric[h+top]
        width.times do |w|
            case row[w+left]
            when "*"
                row[w+left] = claim_id
            when "X"
                next 
            else 
                row[w+left] = "X"
                x_count += 1
            end
        end
    end
end 

puts x_count
