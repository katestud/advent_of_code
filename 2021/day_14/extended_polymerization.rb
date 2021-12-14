class ExtendedPolymerization

  def initialize(file_name = "input.txt")
    raw_template, *raw_instructions = File.readlines(file_name, chomp: true)
    @template = raw_template.split("")
    @instructions = raw_instructions.each_with_object({}) do |instruction, hash|
      next if instruction.empty?
      k, v = instruction.split(" -> ")
      hash[k] = v
    end
  end

  def execute_one
    execute(10)
  end

  def execute_two
    execute(40)
  end

  private

  def execute(iterations)
    polymer = @template.dup
    pair_counts = polymer.each_cons(2).each_with_object(Hash.new(0)) do |(a, b), counts|
      counts["#{a}#{b}"] += 1
    end
    iterations.times do |i|
      new_pair_counts = Hash.new(0)
      # For the instruction {CH => B}
      # Counts: { CH => 1 }
      # Becomes: { CB => 1, BH => 1 }
      pair_counts.each do |pair, count|
        key1 = pair[0] + @instructions[pair]
        key2 = @instructions[pair] + pair[1]
        new_pair_counts[key1] += count
        new_pair_counts[key2] += count
      end
      pair_counts = new_pair_counts
    end
    character_counts = Hash.new(0)
    pair_counts.each do |pair, count|
      character_counts[pair[0]] += count
    end
    character_counts[(@template[-1])] += 1
    min, max = character_counts.minmax_by { |_k, v| v }.map(&:last)
    max - min
  end

end
