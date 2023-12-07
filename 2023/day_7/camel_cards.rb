require_relative "../../src/toolkit"

class CamelCards

  def initialize(file_name = "input.txt")
    @input = File.readlines(file_name, chomp: true)
  end

  def execute_one
    execute(false)
  end

  def execute_two
    execute(true)
  end

  private def execute(with_wildcards)
    hands = @input.map { |line| Hand.new(line, with_wildcards) }
    hands.sort.map.with_index do |hand, index|
      val = hand.bid * (index + 1)
    end.sum
  end
end

class Hand

  attr_reader :bid, :cards, :card_string

  TYPE_SCORING = {
    five: 6,
    four: 5,
    full_house: 4,
    three: 3,
    two_pair: 2,
    one_pair: 1,
    high_card: 0
  }

  def initialize(line, respect_wildcard = false)
    @card_string, bid = line.split
    @bid = bid.to_i
    @cards = @card_string.each_char.map {|c| Card.new(c, respect_wildcard) }
    @respect_wildcard = respect_wildcard
  end

  def <=>(other_hand)
    if type_score != other_hand.type_score
      return type_score <=> other_hand.type_score
    end

    cards.zip(other_hand.cards) do |card, other_card|
      next if card.value == other_card.value
      return card.value <=> other_card.value
    end
  end

  def type_score
    TYPE_SCORING[type]
  end

  def type
    tallied = @cards.map(&:card).tally
    if @respect_wildcard && tallied.key?("J") && tallied.keys.count > 1
      biggest = tallied.max_by{ |k,v| k == "J" ? 0 : v }.first
      tallied[biggest] = tallied[biggest] + tallied.delete("J")
    end

    tallied = tallied.values

    if tallied.any? {|v| v== 5}
      :five
    elsif tallied.any? {|v| v== 4}
      :four
    elsif tallied.any? {|v| v== 3}
      if tallied.any? {|v| v== 2}
        :full_house
      else
        :three
      end
    elsif tallied.any? {|v| v== 2}
      if tallied.count { |v| v == 2} == 2
        :two_pair
      else
        :one_pair
      end
    else
      :high_card
    end
  end

end


class Card

  attr_reader :card

  def initialize(card, wildcard_supported)
    @card = card
    @wildcard_supported = wildcard_supported
  end

  def value
    case @card
    when "A"
      14
    when "K"
      13
    when "Q"
      12
    when "J"
      @wildcard_supported ? 1 : 11
    when "T"
      10
    else
      @card.to_i
    end
  end

end
