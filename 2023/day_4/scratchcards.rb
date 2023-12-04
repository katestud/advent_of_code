require_relative "../../src/toolkit"

class Scratchcards

  def initialize(file_name = "input.txt")
    @input = File.readlines(file_name, chomp: true)
  end

  def execute_one
    @input.map do |card_line|
      calculate_line_score(card_line)
    end.sum
  end

  def execute_two
    card_properties = Hash.new
    @input.each_with_index do |card_line, index|
      count = calculate_wins(card_line)
      if count == 0
        card_properties[index] = {won: [], copies: 1}
      else
        card_properties[index] = {won: (index+1..index+count).to_a, copies: 1}
      end
    end

    total_cards = card_properties.keys.length
    card_properties.each do |index, properties|
      total_cards += (properties[:won].length * properties[:copies])
      properties[:won].each do |copied|
        card_properties[copied][:copies] += properties[:copies]
      end
    end

    total_cards
  end

  private

  def calculate_line_score(line)
    matches = calculate_wins(line)
    case matches
    when 0
      0
    when 1
      1
    else
      2 ** (matches - 1)
    end
  end

  def calculate_wins(line)
    _id, winning, have = line.split(/\:|\|/).map(&:strip).map(&:split)
    (winning & have).length
  end
end
