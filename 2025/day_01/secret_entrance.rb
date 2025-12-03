require_relative "../../src/toolkit"

class SecretEntrance

  def initialize(file_name = "input.txt")
    @input = File.readlines(file_name, chomp: true)
    @position = 50
    @nums = (0..99).to_a
    @directions = @input.map { |l| [ l[0], l[1..-1].to_i ] }
    @count = 0
  end

  def execute_one
    @directions.each do |dir, num|
      if dir == "L"
        @position = (@position - num) % 100
      elsif dir == "R"
        @position = (@position + num) % 100
      else
        raise "Unexpected: #{dir}: #{num}"
      end
      if @position == 0
        @count += 1
      end
    end
    @count
  end

  def execute_two
    @directions.each do |dir, num|
      if dir == "L"
        diff = @position - num

        if @position == 0
          @count += num / 100
        else
          @count += (num + (100 - @position)) / 100
        end
      elsif dir == "R"
        diff = @position + num
        @count += diff.abs / 100
      else
        raise "Unexpected: #{dir}: #{num}"
      end

      @position = diff % 100

    end
    @count
  end
end
