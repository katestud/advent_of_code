require 'rgl/adjacency'

class PassagePathing

  def initialize(file_name = "input.txt")
    @file_name = file_name
    # Just use RGL for help building the graph
    # Don't actually rely on any of its traversal methods
    graph = RGL::AdjacencyGraph.new
    read_file.each do |line|
      graph.add_edge(*line.split('-'))
    end
    @graph = graph.instance_variable_get("@vertices_dict")
    @part_two = false
    @paths = []
  end

  def execute
    @graph["start"].each do |vertex|
      find_paths(vertex, @graph[vertex], [vertex])
      # @graph[vertex].each do |edge|
      #   path = [vertex]
      #   next if edge == "start"
      #   path << edge
      #   if edge == "end"
      #     @paths << path
      #     next
      #   end
      #   @graph[edge].each do |edge_2|
      #     next if edge_2 == "start"
      #     path_2 = path.dup
      #     path_2 << edge_2
      #     if edge_2 == "end"
      #       @paths << path_2
      #       next
      #     end
      #     @graph[edge_2].each do |edge_3|
      #       path_3 = path_2.dup
      #       path_3 << edge_3
      #       next if skip_path?(edge_2, edge_3, path_3)
      #       if edge_3 == "end"
      #         @paths << path_3
      #         next
      #       end
      #       @graph[edge_3].each do |edge_4|
      #         path_4 = path_3.dup
      #         path_4 << edge_4
      #         next if skip_path?(edge_3, edge_4, path_4)
      #         if edge_4 == "end"
      #           @paths << path_4
      #           next
      #         end
      #         @graph[edge_4].each do |edge_5|
      #           path_5 = path_4.dup
      #           path_5 << edge_5
      #           next if skip_path?(edge_4, edge_5, path_5)
      #           if edge_5 == "end"
      #             @paths << path_5
      #             next
      #           end
      #           @graph[edge_5].each do |edge_6|
      #             path_6 = path_5.dup
      #             path_6 << edge_6
      #             next if skip_path?(edge_5, edge_6, path_6)
      #             if edge_6 == "end"
      #               @paths << path_6
      #               next
      #             end
      #             @graph[edge_6].each do |edge_7|
      #               path_7 = path_6.dup
      #               path_7 << edge_7
      #               next if skip_path?(edge_6, edge_7, path_7)
      #               if edge_7 == "end"
      #                 @paths << path_7
      #                 next
      #               end
      #               @graph[edge_7].each do |edge_8|
      #                 path_8 = path_7.dup
      #                 path_8 << edge_8
      #                 next if skip_path?(edge_7, edge_8, path_8)

      #                 if edge_8 == "end"
      #                   @paths << path_8
      #                   next
      #                 end
      #                 @graph[edge_8].each do |edge_9|
      #                   path_9 = path_8.dup
      #                   path_9 << edge_9
      #                   next if skip_path?(edge_8, edge_9, path_9)
      #                   if edge_9 == "end"
      #                     @paths << path_9
      #                     next
      #                   end
      #                   @graph[edge_9].each do |edge_10|
      #                     path_10 = path_9.dup
      #                     path_10 << edge_10
      #                     next if skip_path?(edge_9, edge_10, path_10)
      #                     if edge_10 == "end"
      #                       @paths << path_10
      #                       next
      #                     end
      #                     @graph[edge_10].each do |edge_11|
      #                       path_11 = path_10.dup
      #                       path_11 << edge_11
      #                       next if skip_path?(edge_10, edge_11, path_11)
      #                       if edge_11 == "end"
      #                         @paths << path_11
      #                         next
      #                       end
      #                       @graph[edge_11].each do |edge_12|
      #                         path_12 = path_11.dup
      #                         path_12 << edge_12
      #                         next if skip_path?(edge_11, edge_12, path_12)
      #                         if edge_12 == "end"
      #                           @paths << path_12
      #                           next
      #                         end
      #                         @graph[edge_12].each do |edge_13|
      #                           path_13 = path_12.dup
      #                           path_13 << edge_13
      #                           next if skip_path?(edge_12, edge_13, path_13)
      #                           if edge_13 == "end"
      #                             @paths << path_13
      #                             next
      #                           end
      #                           @paths += find_paths(edge_13, @graph[edge_13], path_13)
      #                         end
      #                       end
      #                     end
      #                   end
      #                 end
      #               end
      #             end
      #           end
      #         end
      #       end
      #     end
      #   end
      # end
    end
  end

  def execute_one
    execute
    @paths.uniq.count
  end

  def execute_two
    @part_two = true
    # execute.sort.map do |path|
    #   puts path.join(",")
    # end
    execute
    @paths.uniq.count
  end

  private

  def read_file
    File.readlines(@file_name, chomp: true)
  end

  def skip_path?(source, edge, path)
    return true if edge == "start"
    if @part_two
      return true if path.last(6) === [source, edge, source, edge, source, edge]
    else
      return true if path.last(4) === [source, edge, source, edge]
    end

    grouped = path.group_by(&:itself)
    if @part_two
      return true if grouped.any? { |k, v| /[[:lower:]]/.match(k) && v.size > 2 }
      grouped.count { |k, v| /[[:lower:]]/.match(k) && v.size > 1 } > 1
    else
      grouped.any? { |k, v| /[[:lower:]]/.match(k) && v.size > 1 }
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
