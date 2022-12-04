class CampCleanup

  def initialize(file_name = "input.txt")
    @file_name = file_name
  end

  def execute_one
    count = 0
    read_file.each do |line|
      one, two = line.split(",")
      first, second = one.split("-")
      third, fourth = two.split("-")
      range1 = (first.to_i..second.to_i)
      range2 = (third.to_i..fourth.to_i)
      if range1.include?(range2.first) && range1.include?(range2.last)
        count += 1
      elsif range2.include?(range1.first) && range2.include?(range1.last)
        count += 1
      end
    end
    count
  end

  def execute_two
    count = 0
    read_file.each do |line|
      one, two = line.split(",")
      first, second = one.split("-")
      third, fourth = two.split("-")
      range1 = (first.to_i..second.to_i)
      range2 = (third.to_i..fourth.to_i)
      if range1.include?(range2.first) || range1.include?(range2.last)
        count += 1
      elsif range2.include?(range1.first) || range2.include?(range1.last)
        count += 1
      end
    end
    count
  end

  private

  def read_file
    File.readlines(@file_name, chomp: true)
  end

end
