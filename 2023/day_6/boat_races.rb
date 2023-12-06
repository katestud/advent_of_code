require_relative "../../src/toolkit"

class BoatRace

  def initialize(file_name = "input.txt")
    @time_row, @record_row = File.readlines(file_name, chomp: true)
  end

  def execute_one
    times = @time_row.split[1..-1].map(&:to_i)
    records = @record_row.split[1..-1].map(&:to_i)
    calculate(times, records)
  end

  def execute_two
    time = @time_row.split[1..-1].join("").to_i
    record = @record_row.split[1..-1].join("").to_i
    calculate([time], [record])
  end

  private
  def calculate(times, records)
    times.map.with_index do |time, index|
      record = records[index]
      1.upto(time).map do |i|
        remaining = time - i
        remaining * i
      end.select { |i| i > record }.count
    end.reduce(&:*)
  end
end
