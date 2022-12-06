class TuningTrouble

  def initialize(file_name = "input.txt")
    @file_name = file_name
  end

  def execute_one
    pos = nil
    read_file.each_cons(4).with_index do |cons, index|
      if cons.uniq.size == 4
        pos = index + 4
        break
      end
    end
    pos
  end

  def execute_two
    read_file.length
  end

  private

  def read_file
    File.readlines(@file_name, chomp: true).first.chars
  end

end
