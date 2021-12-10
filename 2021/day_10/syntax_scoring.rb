class SyntaxScoring

  SYNTAX_SCORING = {
    ")" => 3,
    "]" => 57,
    "}" => 1197,
    ">" => 25137,
  }

  AUTOCOMPLETE_SCORING = {
    ")" => 1,
    "]" => 2,
    "}" => 3,
    ">" => 4,
  }

  EXPECTED_CHAR = {
    "(" => ")",
    "[" => "]",
    "{" => "}",
    "<" => ">",
  }

  def initialize(file_name = "input.txt")
    @file_name = file_name
  end

  def execute_one
    read_file.map do |line|
      invalid = first_invalid_char(line)
      SYNTAX_SCORING[invalid] || 0
    end.sum
  end

  def execute_two
    scores = read_file.reject do |line|
      first_invalid_char(line)
    end.map do |line|
      remaining_chars(line).reduce(0) do |sum, char|
        sum = sum * 5
        sum += AUTOCOMPLETE_SCORING[char]
      end
    end
    scores.sort[(scores.size / 2)]
  end

  private

  def read_file
    File.readlines(@file_name, chomp: true)
  end

  def first_invalid_char(line)
    invalid = nil
    next_expected_closing = []
    line.chars.each do |char|
      if EXPECTED_CHAR.key?(char)
        next_expected_closing << EXPECTED_CHAR[char]
      elsif EXPECTED_CHAR.value?(char)
        if next_expected_closing.last == char
          next_expected_closing.pop
        else
          invalid = char
          break
        end
      end
    end
    invalid
  end

  def remaining_chars(line)
    next_expected_closing = []
    line.chars.each do |char|
      if EXPECTED_CHAR.key?(char)
        next_expected_closing << EXPECTED_CHAR[char]
      elsif EXPECTED_CHAR.value?(char)
        if next_expected_closing.last == char
          next_expected_closing.pop
        end
      end
    end
    next_expected_closing.reverse
  end

end
