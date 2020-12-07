require 'set'

REGEX = /(?<count>\d+) (?<color>.+)(?= bag)/

def read_file
  hash = {}
  File.readlines("input.txt").each do |line|
    color, deps = line.split(" bags contain ")
    hash[color] = find_dependencies(deps)
  end
  hash
end

def build_parents
  @parents = Hash.new
  read_file.each do |color, deps|
    deps.each do |dep|
      child_color, _ = dep
      val = @parents[child_color] || []
      val << color
      @parents[child_color] = val.uniq
    end
  end
  @parents
end

def find_dependencies(dependencies)
  dependencies.split(",").map do |dep|
    match = dep.match(REGEX)
    next unless match
    [
      match[:color],
      match[:count].to_i
    ]
  end.compact
end

def find_parent_bags(color)
  build_parents
  base_parents = @parents[color]
  total_parents = base_parents.dup.uniq

  grandparents = find_grandparents(base_parents)

  until grandparents.empty?
    new_finds = grandparents - total_parents
    total_parents += new_finds
    grandparents = []
    grandparents = find_grandparents(new_finds)
  end
  total_parents.uniq & read_file.keys
end

def find_grandparents(parents)
  @parents.slice(*parents).values.flatten.uniq
end

color = "shiny gold"

puts "Your #{color} bag can have #{find_parent_bags("shiny gold").count} possible parent bags"
