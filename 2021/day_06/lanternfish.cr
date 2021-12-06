class Lanternfish
  @fish : Array(Int32)
  def initialize(input_file = "input.txt")
    @fish = File.read_lines(input_file).first.split(",").map {|i| i.to_i}
  end

  def execute_one
    execute(80)
  end

  def execute_two
    execute(256)
  end


  def execute(times)
    counts = Hash(Int32, Int128).new(0)
    (0..8).each do |i|
      counts[i] = @fish.count(i).to_i128
    end
    times.times do
      zeros = counts[0]
      new_counts = Hash(Int32, Int128).new(0)
      (1..8).to_a.reverse.each do |i|
        j = i-1
        new_counts[j] = counts[i]
      end
      new_counts[8] = zeros
      new_counts[6] = new_counts[6] + new_counts[8]
      counts = new_counts
      # puts counts.inspect
    end
    counts.values.sum
  end
end
