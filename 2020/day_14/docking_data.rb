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
    end.reverse.join

    super(index, new_val)
  end
end


class DockingData

  attr_reader :mem

  def initialize(filename)
    @input = File.readlines(filename, chomp: true)
    @mem = MemoryHash.new
  end

  def find_sum
    @input.each do |line|
      if line =~ /mask/
        self.mask = line.split(" = ")[1]
      else
        eval(line)
      end
    end
    mem.values.map{ |v| v.to_i(2) }.sum
  end

  def mask=(mask)
    mem.mask = mask
  end
end

sum = DockingData.new("test_input.txt").find_sum
puts "TEST INPUT SUM IS: #{sum}"

sum = DockingData.new("input.txt").find_sum
puts "SUM IS: #{sum}"
