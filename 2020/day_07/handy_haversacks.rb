require 'set'

class Haversacks

  CHILD_DEPS_REGEX = /(?<count>\d+) (?<color>.+)(?= bag)/

  attr_reader :rule_dictionary, :color

  def initialize(color)
    @color = color
  end

  def rule_dictionary
    return @rule_dictionary if @rule_dictionary
    @rule_dictionary = {}
    File.readlines("input.txt").each do |line|
      color, deps = line.split(" bags contain ")
      @rule_dictionary[color] = find_dependencies(deps)
    end
    @rule_dictionary
  end

  def build_parents
    @parents = Hash.new
    rule_dictionary.each do |color, deps|
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
      match = dep.match(CHILD_DEPS_REGEX)
      next unless match
      [
        match[:color],
        match[:count].to_i
      ]
    end.compact
  end

  def find_parent_bags
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
    total_parents.uniq & rule_dictionary.keys
  end

  def find_grandparents(parents)
    @parents.slice(*parents).values.flatten.uniq
  end

  def get_child_count
    h = build_child_tree(color)
    get_keys(h).count
  end

  def get_keys(h)
    h.each_with_object([]) do |(k,v),keys|
      keys << k
      keys.concat(get_keys(v)) if v.is_a? Hash
    end
  end

  def build_child_tree(selected_color = nil)
    selected_color ||= color
    tree = {}
    rule_dictionary[selected_color].each do |child_color, child_count|
      child_count.times do |i|
        tree[[child_color, i]] = build_child_tree(child_color)
      end
    end
    tree
  end
end

color = "shiny gold"
h = Haversacks.new(color)

puts "Your #{color} bag can have #{h.find_parent_bags.count} possible parent bags"
puts "Your #{color} bag must have #{h.get_child_count} child bags"
