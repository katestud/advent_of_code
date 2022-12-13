class DistressSignal

  def initialize(file_name = "input.txt")
    @file_name = file_name
  end

  def execute_one
    paragraphs.map.with_index do |paragraph, index|
      first, second = paragraph.split("\n").map {|l| eval(l) }
      correct = correct?(first, second)
      correct ? index + 1 : 0
    end.sum
  end

  def execute_two
    paragraphs.length
  end

  private

  def correct?(first, second)
    index = 0
    loop do
      one = first[index]
      two = second[index]
      if [one, two].all? {|i| i.is_a?(Integer)}
        if one == two
          index += 1
        elsif one > two
          break false
        else
          break true
        end
      elsif [one, two].all?(&:nil?)
        break :continue
      elsif one.nil?
        break true
      elsif two.nil?
        break false
      else
        # either not matching, or both are arrays
        correct = correct?(Array(one), Array(two))
        if correct == :continue
          index += 1
        else
          break correct
        end
      end
    end
  end

  def paragraphs
    File.read(@file_name, chomp: true).split("\n\n")
  end

end
