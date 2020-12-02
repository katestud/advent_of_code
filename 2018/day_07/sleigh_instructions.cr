raw_instructions = File.read("input.txt").split("\n")
instruction_prereqs = {} of String => Array(String)


raw_instructions.each do |instruction|
    instruction_parts = instruction.split
    next unless instruction_parts
    step = instruction_parts[7]
    prereq = instruction_parts[1]

    unless instruction_prereqs[prereq]?
        instruction_prereqs[prereq] = [] of String
    end

    current_prereqs = 
        if instruction_prereqs[step]?
            instruction_prereqs[step]
        else
            [] of String
        end
    instruction_prereqs[step] = current_prereqs << prereq
end

completed_steps = ""

until instruction_prereqs.empty?
    instruction_prereqs.keys.sort.each do |instruction|
        prereqs = instruction_prereqs[instruction]
        if prereqs.any? { |req| instruction_prereqs[req]? }
            next
        else 
            completed_steps += instruction 
            instruction_prereqs.delete(instruction)
            break
        end
    end
end

puts completed_steps