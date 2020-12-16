# Borrowed from https://stackoverflow.com/a/6018744

def ranges_overlap?(a, b)
  a.include?(b.begin) || b.include?(a.begin)
end

def merge_ranges(a, b)
  [a.begin, b.begin].min..[a.end, b.end].max
end

def merge_overlapping_ranges(overlapping_ranges)
  overlapping_ranges.sort_by(&:begin).inject([]) do |ranges, range|
    if !ranges.empty? && ranges_overlap?(ranges.last, range)
      ranges[0...-1] + [merge_ranges(ranges.last, range)]
    else
      ranges + [range]
    end
  end
end
#

rules, your_ticket, nearby_tickets = File.read("input.txt").split("\n\n")

rules.gsub!(" or ", ", ")
rules.gsub!(" ", "")
rules.gsub!("\n", " ],")
rules.gsub!(":", ": [")
rules.gsub!("-", "..")
rules = eval("{#{rules}]}")

your_ticket = your_ticket.split("\n")[1].split(",").map(&:to_i)

nearby_tickets = nearby_tickets.split("\n").drop(1).map do |line|
  line.split(",").map(&:to_i)
end

overlapping_ranges = merge_overlapping_ranges(rules.values.flatten)

invalid_sum = nearby_tickets.flatten.select do |num|
  overlapping_ranges.none? { |range| range.cover?(num) }
end.sum

puts "SUM FOR PART 1:"
puts invalid_sum

valid_tickets = nearby_tickets.select do |ticket|
  ticket.none? { |num| overlapping_ranges.none? { |range| range.cover?(num) } }
end

valid_tickets << your_ticket

rule_positions = Hash.new { |h, k| h[k] = [] }
rule_keys = rules.keys

rule_keys.each do |rule_name|
  ranges = rules[rule_name]

  rule_keys.length.times do |i|
    position = i
    valid = valid_tickets.all? do |ticket|
      ranges.find { |range| range.cover?(ticket[position]) }
    end

    if valid
      rule_positions[rule_name] << position
    end
  end
end

possible_positions = (0...rule_keys.length).to_a

inverted = rule_positions.invert

final_positions = {}

inverted.keys.sort_by {|k| k.length }.each do |key|
  rule_name = inverted[key]
  correct_position = (possible_positions & key).first
  final_positions[rule_name] = correct_position
  possible_positions -= [correct_position]
end

product = rule_keys.select { |r| r =~ /departure/ }.map do |rule_name|
  your_ticket[final_positions[rule_name]]
end.inject(&:*)

puts "PRODUCT FOR PART 2:"
puts product
