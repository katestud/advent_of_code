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
    @input = File.readlines(file_name, chomp: true)
  end

  def execute_one
    @input.map do |line|
      invalid_char, _ = expected_remaining_chars(line)
      SYNTAX_SCORING[invalid_char] || 0
    end.sum
  end

  def execute_two
    scores = @input.filter_map do |line|
      invalid_char, remaining_chars = expected_remaining_chars(line)
      next if invalid_char
      remaining_chars.reduce(0) do |sum, char|
        sum = sum * 5
        sum += AUTOCOMPLETE_SCORING[char]
      end
    end
    scores.sort[(scores.size / 2)]
  end

  private

  def expected_remaining_chars(line)
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
    [invalid, next_expected_closing.reverse]
  end

end
