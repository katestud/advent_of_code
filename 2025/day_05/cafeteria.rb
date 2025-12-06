require_relative "../../src/toolkit"

class Cafeteria

  def initialize(file_name = "input.txt")
    ranges, ids = read_file_into_batches(file_name)
    @ranges = ranges.map do |range_string|
      f, l = range_string.split("-").map(&:to_i)
      (f..l)
    end
    @available_ids = ids.map(&:to_i).to_set
  end

  def execute_one
    @available_ids.count do |i|
      @ranges.any? { |range| range.cover?(i) }
    end
  end

  def execute_two
    collapsed = @ranges.sort_by(&:begin)
    searching = true
    while searching
      searching = false
      ranges = collapsed.dup
      collapsed = []
      while ranges.length > 0
        candidate = ranges.shift
        friend = ranges.detect { |r| r.cover?(candidate.begin) || r.cover?(candidate.end) || candidate.cover?(r.begin) || candidate.cover?(r.end) }
        if friend
          searching = true
          ranges.delete(friend)
        end
        all = [friend, candidate].compact
        collapsed << (all.map(&:begin).min..all.map(&:end).max)
      end
    end
    collapsed.sum { |r| r.size }
  end
end
