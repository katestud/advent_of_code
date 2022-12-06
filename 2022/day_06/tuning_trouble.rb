class TuningTrouble

  def initialize(file_name = "input.txt")
    @file_name = file_name
  end

  def execute_one
    find_starting_marker(4)
  end

  def execute_two
    find_starting_marker(14)
  end

  private

  def find_starting_marker(size)
    pos = nil
    read_file.each_cons(size).with_index do |cons, index|
      if cons.uniq.size == size
        pos = index + size
        break
      end
    end
    pos
  end

  def read_file
    File.readlines(@file_name, chomp: true).first.chars
  end

end
