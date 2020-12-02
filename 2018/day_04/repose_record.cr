class Record
    def initialize(log : String)
        @log = log
    end

    def date
        match = @log.match(/\[(.*?)\]/)
        if match
            date = match[0]
            year = date[1..4].to_i
            month = date[6..7].to_i
            day = date[9..10].to_i
            hour = date[12..13].to_i
            minute = date[15..16].to_i
            Time.new(year, month, day, hour, minute)
        else 
            Time.new(1518, 0, 0)
        end
    end

    def beginning_of_shift?
        if @log.match(/Guard/)
            guard_id
        end 
    end

    def guard_id
        match = @log.match(/\#(\d*)/)
        match[0][1..-1].to_i if match
    end
end

class RecordLog

    def initialize(records : Array(Record))
        @records = records
    end

    def extract_sleep_ranges
        @records.in_groups_of(2).map do |group|
            sleep = group[0]
            wake = group[1]
            (sleep.date.minute...wake.date.minute) if sleep && wake
        end
    end
end


input = File.read("input.txt").split("\n")
repose_record = {} of Int32 => Hash(Int32, Int32)
current_guard_id = 0

input.map { |line| Record.new line }
    .sort_by {|r| r.date }
    .chunks { |r| r.beginning_of_shift? }.each do |chunk|
        if chunk[0]
            current_guard_id = chunk[0] 
        else
            guard_record = 
                if repose_record[current_guard_id]?
                    repose_record[current_guard_id]
                else 
                    {} of Int32 => Int32
                end 
            records = RecordLog.new chunk[1]
            records.extract_sleep_ranges.compact.each do |range|
                range.to_a.each do |n|
                    sleep_val = if guard_record[n]?
                        guard_record[n] + 1
                    else 
                        1
                    end 
                    guard_record[n] = sleep_val
                end
            end
            repose_record[current_guard_id] = guard_record if current_guard_id
        end
end

totals = {} of Int32 => Int32
max = repose_record.max_by do |sleep_record|
    sleep_times = sleep_record[1].values.sum
end

sleepiest_minute = repose_record.max_by do |sleep_record|
    sleep_record[1].values.max
end

puts sleepiest_minute