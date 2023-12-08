require_relative "../../src/toolkit"

class HauntedWasteland

  def initialize(file_name = "input.txt")
    @instructions, *nodes = File.readlines(file_name, chomp: true)
    nodes.shift
    build_graph(nodes)
  end

  INDEX_MAP = { "L" => 0, "R" => 1}

  def execute_one
    pos = "AAA"
    steps = 0
    @instructions.each_char.cycle do |direction|
      steps += 1
      index = INDEX_MAP[direction]
      pos = @graph[pos][index]
      break if pos == "ZZZ"
    end
    steps
  end

  def execute_two
    0
  end

  private

  def build_graph(nodes)
    @graph = {}
    nodes.each do |node_line|
      key, *value = node_line.scan(/\w{3}/)
      @graph[key] = value
    end
  end
end
