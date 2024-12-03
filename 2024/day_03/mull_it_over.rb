require_relative "../../src/toolkit"

class MullItOver

  REGEX = /mul\((\d{1,3}),(\d{1,3})\)/
  REGEX_TWO = /(mul)\((\d{1,3}),(\d{1,3})\)|(do)\(\)|(don\'t)\(\)/

  def initialize(file_name = "input.txt")
    @input = File.read(file_name, chomp: true)
  end

  def execute_one
    @input.scan(REGEX).map do |match|
      mul(*match.map(&:to_i))
    end.sum
  end

  def execute_two
    use = true
    to_execute = []
    @input.scan(REGEX_TWO).each do |match|
      if match[0] == "mul"
        to_execute << match[1,2].map(&:to_i) if use
      elsif match[3] == "do"
        use = true
      elsif match[4] == "don't"
        use = false
      end
    end
    to_execute.map { |m| mul(*m) }.sum
  end

  private
  def mul(x,y)
    x * y
  end
end
