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

class Mirror
  def initialize(pattern, check_smudge)
    @pattern = pattern
    @valid = false
    @check_smudge = check_smudge
    @potential_smudge_found = false
    traverse
  end

  def valid?
    @valid
  end

  def traverse
    @pattern.each_with_index do |row, index|
      if rows_are_equal?(row, @pattern[index+1]) && check_all_neighbors(index-1, index+2)
        next if @check_smudge && !@potential_smudge_found
        @valid = true
        @fold = index + 1
        return true
      end
      @potential_smudge_found = false
    end
  end

  def rows_are_equal?(row1, row2)
    return false if row1.nil? || row2.nil?

    complete_match = row1 == row2
    return true if complete_match

    return complete_match unless @check_smudge && !@potential_smudge_found

    match_count = row1.zip(row2).count do |val1, val2|
      val1 == val2
    end
    if match_count == row1.length - 1
      @potential_smudge_found = true
      return true
    end
    false
  end

  def check_all_neighbors(top, bottom)
    loop do
      return true if top == -1 || bottom == @pattern.length # Out of bounds
      return false unless rows_are_equal?(@pattern[top], @pattern[bottom])
      top = top - 1
      bottom = bottom + 1
    end
  end
end

class RowMirror < Mirror
  def score
    @fold * 100
  end
end

class ColumnMirror < Mirror
  def score
    @fold
  end

  def traverse
    @pattern = @pattern.transpose
    super()
  end
end
