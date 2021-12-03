class BinaryDiagnostic

  def initialize(file_name = "input.txt")
    @input = File.readlines(file_name, chomp: true).map(&:chars)
  end

  def execute_one
    zipped = @input.first.zip(*@input[1..-1])
    gamma = zipped.map do |digits|
      digits.max_by {|digit| digits.count(digit) }
    end
    epsilon = zipped.map do |digits|
      digits.min_by {|digit| digits.count(digit) }
    end
    gamma.join.to_i(2) * epsilon.join.to_i(2)
  end

  def execute_two
    oxygen(@input) * co2(@input)
  end

  private

  def oxygen(input)
    remaining = input
    index = 0
    while remaining.length > 1
      zeros = remaining.map { |i| i[index] }.count("0")
      if zeros > remaining.length - zeros
        remaining = remaining.select {|row| row[index] == "0" }
      else
        remaining = remaining.select {|row| row[index] == "1" }
      end
      index += 1
    end
    remaining.join.to_i(2)
  end

  def co2(input)
    remaining = input
    index = 0
    while remaining.length > 1
      zeros = remaining.map { |i| i[index] }.count("0")
      if zeros <= remaining.length - zeros
        remaining = remaining.select {|row| row[index] == "0" }
      else
        remaining = remaining.select {|row| row[index] == "1" }
      end
      index += 1
    end
    remaining.join.to_i(2)
  end

end
