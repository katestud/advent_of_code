class SupplyStacks

  TEST_INPUT = [
    %w(Z N),
    %w(M C D),
    %w(P)
  ]
  INPUT = [
    %w(D T W F J S H N),
    %w(H R P Q T N B G),
    %w(L Q V),
    %w(N B S W R Q),
    %w(N D F T V M B),
    %w(M D B V H T R),
    %w(D B Q J),
    %w(D N J V R Z H Q),
    %w(B N H M S)
  ]

  INSTRUCTION_MATCH = /move (?<count>\d+) from (?<start>\d+) to (?<dest>\d+)/

  def initialize(file_name = "input.txt")
    @file_name = file_name
  end

  def execute_one
    steps = read_file.split("\n\n").last.split("\n")
    input = @file_name == "test_input.txt" ? TEST_INPUT.dup : INPUT.dup
    steps.each do |step|
      match = INSTRUCTION_MATCH.match(step)
      count = match[:count].to_i
      start = match[:start].to_i - 1
      dest = match[:dest].to_i - 1
      count.times do
        input[dest] << input[start].pop
      end
    end
    input.map(&:last).join
  end

  def execute_two
    read_file.length
  end

  private

  def read_file
    File.read(@file_name, chomp: true)
  end

end
