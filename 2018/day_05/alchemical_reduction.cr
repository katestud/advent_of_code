input = File.read("input.txt")

# Part 1 Solution
loop do
    fully_reacted = true
    new_string = ""
    iterator = input.chars.each_cons(2)
    char = '.'
    next_char = '.'
    loop do 
        cons = iterator.next
        if cons.is_a?(Iterator::Stop)
            new_string = new_string + next_char
            break
        end
        char = cons[0]
        next_char = cons[1] 
        if char && next_char
            if (char.downcase == next_char.downcase) && (char != next_char)
                fully_reacted = false
                iterator.next
            else
                new_string = new_string + char
            end
        end
    end
    puts new_string.size
    break if fully_reacted 
    input = new_string
end

# Part 2 Solution
polymer_results = {} of Char => Int32
('a'..'z').each { |char| polymer_results[char] = 0 }

('a'..'z').each do |polymer|
    string = input.dup.delete { |c| [polymer, polymer.upcase].includes?(c) }
    puts string.size
    loop do
        fully_reacted = true
        new_string = ""
        iterator = string.chars.each_cons(2)
        char = '.'
        next_char = '.'
        loop do 
            cons = iterator.next
            if cons.is_a?(Iterator::Stop)
                new_string = new_string + next_char
                break
            end
            char = cons[0]
            next_char = cons[1] 
            if char && next_char
                if (char.downcase == next_char.downcase) && (char != next_char)
                    fully_reacted = false
                    iterator.next
                else
                    new_string = new_string + char
                end
            end
        end
        puts new_string.size
        if fully_reacted 
            polymer_results[polymer] = new_string.size
            puts "Finished"
            puts polymer
            break
        end
        string = new_string
    end
end

puts polymer_results