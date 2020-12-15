class MemoryHash < Hash

  attr_accessor :mask

  def []=(index, val)
    val_array = val.to_s(2).reverse.each_char.to_a
    reversed_mask = mask.reverse.each_char.to_a
    new_val = reversed_mask.map.with_index do |char, index|
      if char != "X"
        char
      elsif val_array[index]
        val_array[index]
      else
        "0"
      end
    end.reverse.join.to_i(2)

    super(index, new_val)
  end
end
class MemoryDecoderHash < Hash

  attr_accessor :mask

  # If the bitmask bit is 0, the corresponding memory address bit is unchanged.
  # If the bitmask bit is 1, the corresponding memory address bit is overwritten with 1.
  # If the bitmask bit is X, the corresponding memory address bit is floating.

  def []=(position, val)
    position = position.to_s(2).reverse.each_char.to_a
    result = mask.reverse.each_char.to_a.map.with_index do |char, index|
      if char == "0"
        position[index] || "0"
      elsif char == "1"
        "1"
      else
        "X"
      end
    end.reverse.join

    # Hat tip to @jhawthorn for the flat_map idea from below
    floats = [result]

    result.count("X").times do
      floats =
        floats.flat_map do |x|
          [x.sub("X", "0"), x.sub("X", "1")]
        end
    end

    floats.map{ |x| x.to_i(2) }.each do |float|
      super(float, val)
    end
  end
end


class DockingData

  attr_reader :mem

  def initialize(filename, part: 1)
    @input = File.readlines(filename, chomp: true)
    @mem = part == 1 ? MemoryHash.new : MemoryDecoderHash.new
  end

  def find_sum
    @input.each do |line|
      if line =~ /mask/
        self.mask = line.split(" = ")[1]
      else
        eval(line)
      end
    end
    mem.values.sum
  end

  def mask=(mask)
    mem.mask = mask
  end
end

sum = DockingData.new("test_input.txt").find_sum
puts "TEST INPUT SUM IS: #{sum}"

sum = DockingData.new("input.txt").find_sum
puts "SUM IS: #{sum}"

sum = DockingData.new("test_input.txt", part: 2).find_sum
puts "TEST INPUT SUM IS: #{sum}"

sum = DockingData.new("input.txt", part: 2).find_sum
puts "SUM IS: #{sum}"
