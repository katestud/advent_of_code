require_relative "../../src/toolkit"

class DiskFragmenter

  def initialize(file_name = "input.txt")
    @input = File.read(file_name).chomp.each_char.to_a.map(&:to_i)
  end

  def execute_one
    last_index = (@input.length - 1) / 2
    last_count_remaining = @input.pop
    new_array = []
    remaining_spaces = 0
    @input.each_slice(2).with_index do |(count, gap_count), index|
      new_array = new_array + count.times.map { index }
      while gap_count > 0
        if last_count_remaining > 0
          if last_count_remaining > gap_count
            new_array = new_array + gap_count.times.map { last_index }
            last_count_remaining -= gap_count
            gap_count = 0
          elsif last_count_remaining == gap_count
            new_array = new_array + gap_count.times.map { last_index }
            last_count_remaining, gaps = @input.slice!(-2, 2)
            last_index -= 1
            gap_count = 0
          elsif last_count_remaining < gap_count
            new_array = new_array + last_count_remaining.times.map { last_index }
            gap_count -= last_count_remaining
            last_count_remaining, gaps = @input.slice!(-2, 2)
            last_index -= 1
          end
        else
          break
        end
      end
    end
    if last_count_remaining > 0
      new_array = new_array + last_count_remaining.times.map { last_index }
    end
    new_array.map.with_index do |v, index|
      v * index
    end.sum
  end

  def execute_two
    @input.length
  end
end
