frequency = 0
found_frequencies = Set.new([] of Int32)
first_dup = nil
instructions = File.read("input.txt").split("\n")

until first_dup
    instructions.each do |item|
        frequency += item.to_i
        if found_frequencies.includes?(frequency) 
            first_dup = frequency
            puts first_dup
            break
        end
        found_frequencies.add(frequency)
    end
end
