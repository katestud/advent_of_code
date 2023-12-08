require_relative "../../src/toolkit"

class HauntedWasteland

  def initialize(file_name = "input.txt")
    @instructions, *nodes = File.readlines(file_name, chomp: true)
    nodes.shift
    build_graph(nodes)
  end

  INDEX_MAP = { "L" => 0, "R" => 1}

  def execute_one
    find_steps("AAA", false)
  end

  def execute_two
    positions = @graph.keys.select {|k| k[-1] == "A"}
    positions.map do |p|
      find_steps(p, true)
    end.reduce(1, :lcm)
  end

  private

  def build_graph(nodes)
    @graph = {}
    nodes.each do |node_line|
      key, *value = node_line.scan(/\w{3}/)
      @graph[key] = value
    end
  end

  def find_steps(pos, end_only = false)
    steps = 0
    @instructions.each_char.cycle do |direction|
      steps += 1
      index = INDEX_MAP[direction]
      pos = @graph[pos][index]
      break if pos == "ZZZ"
      break if pos[-1] == "Z" && end_only
    end
    steps
  end
end
