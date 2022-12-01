class CalorieCounter

  def initialize(file_name = "input.txt")
    @file_name = file_name
    @batches = read_file.split("\n\n").map { |b| b.split("\n") }
  end

  def execute_one
    @batches.map do |batch|
      batch.map(&:to_i).sum
    end.max
  end

  def execute_two
    @batches.map do |batch|
      batch.map(&:to_i).sum
    end.sort.reverse.take(3).sum
  end

  private

  def read_file
    File.read(@file_name, chomp: true)
  end

end
