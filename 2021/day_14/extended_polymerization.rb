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
    puts @instructions.inspect
    polymer = @template.dup
    10.times do
      new_polymer = []
      polymer.each_cons(2) do |a, b|
        new_polymer << a
        if @instructions.key?("#{a}#{b}")
          new_polymer << @instructions["#{a}#{b}"]
        end
      end
      new_polymer << polymer.last
      polymer = new_polymer
    end
    counts = polymer.group_by(&:itself).map { |k, v| [k, v.size] }.to_h
    min, max = counts.minmax_by { |_k, v| v }.map(&:last)
    max - min
  end

  def execute_two
    0
  end

  private

end
