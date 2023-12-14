require_relative "../../src/toolkit"

class ParabolicReflector

  def initialize(file_name = "input.txt")
    @input = File.readlines(file_name, chomp: true).map(&:each_char).map(&:to_a)
  end

  def execute_one
    score(tilt_north(@input))
  end

  def execute_two
    platform = cycle(@input, 1_000_000_000)
    score(platform)
  end

  private

  def cycle(platform, count)
    cycle_configs = {}
    cache_hit_found = false

    i = 0
    until i >= count
      platform = full_tilt(platform)

      key = platform.join
      prev_cycle = cycle_configs[key]
      if prev_cycle && !cache_hit_found
        num_cycles_since = i - prev_cycle
        cycle_configs[key] = i
        i = i + (((count - i) / num_cycles_since) * num_cycles_since) + 1
        cache_hit_found = true
      else
        cycle_configs[key] = i
        i += 1
      end
    end
    platform
  end

  def full_tilt(platform)
    platform = tilt_north(platform)
    platform = tilt_west(platform)
    platform = tilt_south(platform)
    platform = tilt_east(platform)
  end

  def tilt_north(platform)
    tilt(platform.transpose).transpose
  end

  def tilt_west(platform)
    tilt(platform)
  end

  def tilt_south(platform)
    tilt(platform.transpose, true).transpose
  end

  def tilt_east(platform)
    tilt(platform, true)
  end

  def tilt(platform, down = false)
    platform.map do |column|
      length = column.size
      chunks = column.join.split("#")
      new_string = chunks.map do |chunk|
        sorted = chunk.each_char.sort
        if !down
          sorted.reverse!
        end
        sorted.join
      end.join("#")
      if length > new_string.size
        new_string += "#" * (length-new_string.size)
      end
      new_string.each_char.to_a
    end
  end

  def score(platform)
    length = platform.length
    platform.map.with_index do |row, index|
      val = row.count { |r| r == "O"} * (length - index)
    end.sum
  end

end
