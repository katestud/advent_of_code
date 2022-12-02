class RockPaperScissors

  SCORING = {
    "X" => 1,
    "Y" => 2,
    "Z" => 3
  }

  OUTCOMES = {
    "X" => 0,
    "Y" => 3,
    "Z" => 6
  }

  # A - Rock, B - Paper, C - Scissors
  # X - Rock, Y - Paper, Z - Scissors

  BEATS = {
    "A" => "Z",
    "B" => "X",
    "C" => "Y"
  }

  TIES = {
    "A" => "X",
    "B" => "Y",
    "C" => "Z"
  }

  LOSES = {
    "A" => "Y",
    "B" => "Z",
    "C" => "X"
  }

  DRAWS =   ["A X", "B Y", "C Z"]
  LOSSES =  ["A Z", "B X", "C Y"]
  WINS =    ["A Y", "B Z", "C X"]

  def initialize(file_name = "input.txt")
    @file_name = file_name
  end

  def execute_one
    score = 0
    read_file.each do |round|
      if DRAWS.include? round
        score += 3
      elsif WINS.include? round
        score += 6
      end
      score += SCORING[round.split.last]
    end
    score
  end

  def execute_two
    score = 0
    read_file.each do |round|
      played, outcome = round.split
      score += OUTCOMES[outcome]
      if outcome == "X"
        score += SCORING[BEATS[played]]
      elsif outcome == "Y"
        score += SCORING[TIES[played]]
      else
        score += SCORING[LOSES[played]]
      end
    end
    score
  end

  private

  def read_file
    File.readlines(@file_name, chomp: true)
  end

end
