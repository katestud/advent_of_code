require "set"

input = File.read("input.txt").split("\n\n")
deck_one, deck_two = input.map do |deck|
  deck.split("\n")[1..-1].map(&:to_i)
end

def calculate_score(deck)
  deck.map.with_index do |card, index|
    (deck.length - index) * card
  end.sum
end

def play_game_one(deck_one, deck_two)
  until deck_one.empty? || deck_two.empty?
    one = deck_one.shift
    two = deck_two.shift
    if one > two
      deck_one << one
      deck_one << two
    else
      deck_two << two
      deck_two << one
    end
  end
  [deck_one, deck_two]
end

def play_game_two(deck_one, deck_two)
  gameset = Set.new([deck_one, deck_two])
  until deck_one.empty? || deck_two.empty?
    unless gameset.add?([deck_one, deck_two])
      break
    end
    one = deck_one.shift
    two = deck_two.shift
    winning_deck, winning_card, losing_card = find_winner(one, deck_one, two, deck_two)
    if winning_deck == deck_one
      deck_one << winning_card
      deck_one << losing_card
    else
      deck_two << winning_card
      deck_two << losing_card
    end
  end
  [deck_one, deck_two]
end

def find_winner(card_one, deck_one, card_two, deck_two)
  if card_one <= deck_one.count && card_two <= deck_two.count
    one, two = play_game_two(deck_one.take(card_one), deck_two.take(card_two))
    if one.empty?
      return [deck_two, card_two, card_one]
    else
      return [deck_one, card_one, card_two]
    end
  end
  if card_one > card_two
    [deck_one, card_one, card_two]
  else
    [deck_two, card_two, card_one]
  end
end

puts "PART 1 GAME FINAL SCORE:"
final = play_game_one(deck_one.dup, deck_two.dup)

winner = final.detect { |deck| !deck.empty? }

puts calculate_score(winner)

puts "PART 2 GAME FINAL SCORE:"

final = play_game_two(deck_one.dup, deck_two.dup)

winner = final.detect { |deck| !deck.empty? }

puts calculate_score(winner)
