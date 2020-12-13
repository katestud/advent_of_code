class ShuttleSearch
  @input : Array(Int32)
  def initialize(input_data)
    @input = input_data.split(",").map { |i| i.to_i { 0 } }
  end

  def find_start_time
    start_time = Int64.new(@input[0])
    interval = start_time
    matches = Set{0, start_time}
    all_match = false

    until all_match
      all_match = true
      time = start_time
      @input.each do |val|
        if (val != 0) && (time % val != 0)
          all_match = false
        elsif matches.add?(val)
          interval *= val
        end
        time += 1
      end
      start_time += interval unless all_match
    end

    start_time
  end
end
