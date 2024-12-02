require_relative "../../src/toolkit"

class RedNosedReports

  def initialize(file_name = "input.txt")
    @input = File.readlines(file_name, chomp: true).map do |l|
      l.split(" ").map(&:to_i)
    end
  end

  def execute_one
    @input.select do |report|
      is_a_safe_report?(report)
    end.count
  end

  def execute_two
    @input.select do |report|
      if is_a_safe_report?(report)
        true
      else
        report.each_with_index.detect do |l, i|
          duped = report.dup
          duped.delete_at(i)
          break true if is_a_safe_report?(duped)
        end
      end
    end.count
  end

  private

  def is_a_safe_report?(report)
    dir = nil
    report.each_cons(2) do |i, j|
      diff = i - j
      return false if diff.zero?
      if diff < 0
        new_dir = :dec
      else
        new_dir = :inc
      end
      return false if dir && dir != new_dir
      dir = new_dir
      return false if diff.abs > 3
      true
    end
  end
end
