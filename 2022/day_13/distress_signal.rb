class DistressSignal

  def initialize(file_name = "input.txt")
    @file_name = file_name
  end

  def execute_one
    paragraphs.map.with_index do |paragraph, index|
      first, second = paragraph.split("\n").map { |l| eval(l) }
      correct = Packet.new(first) <=> Packet.new(second)
      correct > 0 ? index + 1 : 0
    end.sum
  end

  def execute_two
    rows = [[[2]], [[6]]]
    paragraphs.each {|p| p.split("\n").map { |l| rows << eval(l) } }
    sorted = rows.sort { |r1, r2| Packet.new(r2) <=> Packet.new(r1) }
    (sorted.index([[2]]) + 1) * (sorted.index([[6]]) + 1)
  end

  private

  def paragraphs
    File.read(@file_name, chomp: true).split("\n\n")
  end

end

class Packet

  attr_accessor :arr

  def initialize(arr)
    @arr = Array(arr)
  end

  def <=>(second)
    index = 0
    loop do
      one = arr[index]
      two = second.arr[index]
      if [one, two].all? {|i| i.is_a?(Integer)}
        if one == two
          index += 1
        elsif one > two
          break -1
        else
          break 1
        end
      elsif [one, two].all?(&:nil?)
        break :continue
      elsif one.nil?
        break 1
      elsif two.nil?
        break -1
      else
        # either not matching, or both are arrays
        correct = Packet.new(one) <=> Packet.new(two)
        if correct == :continue
          index += 1
        else
          break correct
        end
      end
    end
  end
end
