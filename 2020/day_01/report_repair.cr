class Report

  @sorted_input : Array(Int32)

  def initialize(input_file = "input.txt")
    input = File.read_lines(input_file).map { |s| s.to_i32 }
    @sorted_input = input.sort
  end

  def find_product
    @sorted_input.each do |i|
      a = i
      b = 2020 - a
      return a * b if @sorted_input.includes?(b)
    end
  end

  def find_triple_product
    @sorted_input.each do |i|
      a = i
      rem = 2020 - a
      @sorted_input.each do |j|
        next if j == i
        b = j
        c = rem - j
        return a * b * c if @sorted_input.includes?(c)
      end
    end
  end
end

puts Report.new.find_product
puts Report.new.find_triple_product
