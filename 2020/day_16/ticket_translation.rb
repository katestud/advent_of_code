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

nearby_tickets = nearby_tickets.split("\n").drop(1).map do |line|
  line.split(",").map(&:to_i)
end

overlapping_ranges = merge_overlapping_ranges(rules.values.flatten)

invalid_sum = nearby_tickets.flatten.select do |num|
  overlapping_ranges.none? { |range| range.cover?(num) }
end.sum

puts "SUM FOR PART 1:"
puts invalid_sum
