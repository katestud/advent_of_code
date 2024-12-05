require_relative "../../src/toolkit"

class PrintQueue

  def initialize(file_name = "input.txt")
    rules, manuals = read_file_into_batches(file_name)
    @rules = parse_rules(rules)
    @manuals = parse_manuals(manuals)
    @correct, @incorrect = @manuals.partition do |manual|
      @rules.all? do |k, v|
        next true unless manual.include?(k)
        l, r = manual.slice_when { |m, i| m == k }.to_a
        (l & v).empty?
      end
    end
  end

  def execute_one
    @correct.map do |manual|
      manual[manual.length / 2]
    end.sum
  end

  def execute_two
    @rules.length
  end

  private

  def parse_rules(rules)
    rule_hash = Hash.new { |h, k| h[k] = [] }
    rules.each do |rule|
      k, v = rule.split("|")
      rule_hash[k.to_i] << v.to_i
    end
    rule_hash
  end

  def parse_manuals(manuals)
    manuals.map { |m| m.split(",").map(&:to_i) }
  end
end
