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

  def visualize()
    time = 15
    boats = 1.upto(time).map do |i|
      remaining = time - i
      Boat.new(start_time: i, speed: i)
    end

    print_boats(boats, "Preparing to Race!", 15)
    print_boats(boats, "On your Mark...", 1)
    print_boats(boats, "Get set...", 1)
    print_boats(boats, "Go!!!", 1)

    1.upto(time).each do |timer|
      boats.each(&:travel)
      print_boats(boats, "The races are on!", 0.75)
    end
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

  def print_boats(boats, message, sleep)
    puts message
    puts "="*60
    puts boats
    puts "="*60
    sleep sleep
  end
end


class Boat
  def initialize(start_time:, speed:)
    @start_time = start_time
    @speed = speed
    @current_time = 0
  end

  def travel
    @current_time += 1
  end

  def traveled_distance
    return 0 unless @current_time > @start_time
    (@current_time - @start_time) * @speed
  end

  def to_s
    "-"*traveled_distance + ">" + "🚣"
  end
end
