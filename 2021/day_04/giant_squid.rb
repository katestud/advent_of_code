class GiantSquid

  def initialize(file_name = "input.txt")
    input = File.read(file_name, chomp: true).split("\n\n")
    @nums = input.shift.split(",")
    @boards = input.map { |row| row.split("\n").map(&:strip).map(&:split).map { |row| row.map {|num| [num, false]} } }
  end

  def execute_one
    @nums.each do |num|
      @boards.each do |board|
        board.each do |row|
          if match = row.detect { |tuple| tuple[0] == num }
            match[1] = true
          end
        end
        if winning_board?(board)
          return board_score(board) * num.to_i
        end
      end
    end
  end

  def execute_two
    boards = @boards.dup
    @nums.each do |num|
      boards.each do |board|
        board.each do |row|
          if match = row.detect { |tuple| tuple[0] == num }
            match[1] = true
          end
        end
      end
      boards.each do |board|
        if winning_board?(board)
          if boards.length == 1
            return board_score(board) * num.to_i
          else
            boards.delete(board)
          end
        end
      end
    end
  end

  private

  def winning_board?(board)
    return true if board.any? { |row| row.all? { |(k, v)| v } }
    (0..4).each do |index|
      return true if board.map { |row| row[index] }.all? { |(k, v)| v }
    end
    false
  end

  def board_score(board)
    board.map { |row| row.map { |(k, v)| v ? 0 : k.to_i } }.flatten.sum
  end

end
