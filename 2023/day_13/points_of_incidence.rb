require_relative "../../src/toolkit"

class IncidencePoints

  def initialize(file_name = "input.txt")
    @input = read_file_into_batches(file_name).map { |b| b.map(&:each_char).map(&:to_a)}
  end

  def execute_one
    execute(false)
  end

  def execute_two
    execute(true)
  end

  private

  def execute(smudge)
    @input.map do |pattern|
      m = RowMirror.new(pattern, smudge)
      if !m.valid?
        m = ColumnMirror.new(pattern, smudge)
      end
      m.score
    end.sum
  end

end

class RowMirror
  def initialize(pattern, smudge)
    @pattern = pattern
    @valid = false
    @check_smudge = smudge
    @smudged = false
    traverse
  end

  def valid?
    @valid
  end

  def score
    (@index + 1) * 100
  end

  def traverse
    @pattern.each_with_index do |row, index|
      if rows_are_equal?(row, @pattern[index+1])
        if double_check_match(index-1, index+2)
          next if @check_smudge && !@smudged
          @valid = true
          @index = index
          return true
        end
      end
      @smudged = false
    end
  end

  def rows_are_equal?(row1, row2)
    return false if row1.nil? || row2.nil?
    return row1 == row2 unless @check_smudge
    return row1 == row2 if @smudged
    match_count = row1.zip(row2).count do |val1, val2|
      val1 == val2
    end
    if match_count == row1.length
      return true
    elsif match_count == row1.length - 1
      @smudged = true
      return true
    end
    false
  end

  def double_check_match(top, bottom)
    until @pattern[top].nil? || @pattern[bottom].nil?
      return true if top == -1
      return true if bottom == @pattern.length
      return false unless rows_are_equal?(@pattern[top], @pattern[bottom])
      return true if top == 0
      top = top - 1
      bottom = bottom + 1
    end
    true
  end
end

class ColumnMirror < RowMirror

  def score
    @index + 1
  end

  def traverse
    @pattern = @pattern.transpose
    super()
  end

end
