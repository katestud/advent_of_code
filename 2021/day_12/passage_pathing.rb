require 'rgl/adjacency'

class PassagePathing

  def initialize(file_name = "input.txt")
    # Just use RGL for help building the graph
    # Don't actually rely on any of its traversal methods
    graph = RGL::AdjacencyGraph.new
    File.readlines(file_name, chomp: true).each do |line|
      graph.add_edge(*line.split('-'))
    end
    @graph = graph.instance_variable_get("@vertices_dict")
    @paths = []
  end

  def execute(part: 1)
    @part = part
    @graph["start"].each do |vertex|
      find_paths(vertex, @graph[vertex], [vertex])
    end
    @paths.uniq.count
  end

  private

  def skip_path?(source, edge, path)
    return true if edge == "start"
    # really for part 1, we could just look at the last 4, but this cleans up the logic a bit and doesn't seem to affect perf in a significant way.
    return true if path.last(6) === [source, edge, source, edge, source, edge]

    grouped = path.group_by(&:itself)
    return true if grouped.any? { |k, v| /[[:lower:]]/.match(k) && v.size > @part }

    if @part == 2
      grouped.count { |k, v| /[[:lower:]]/.match(k) && v.size > 1 } > 1
    else
      false
    end
  end

  def find_paths(source, vertices, path)
    vertices.each do |edge|
      next unless new_path = find_path(source, edge, path)
      find_paths(edge, @graph[edge], new_path)
    end
  end

  def find_path(source, edge, path)
    new_path = path.dup
    new_path << edge
    return if skip_path?(source, edge, new_path)

    if edge == "end"
      @paths << new_path
      return
    end

    new_path
  end
end
