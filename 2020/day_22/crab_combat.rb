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

final = play_game_one(deck_one, deck_two)

winner = final.detect { |deck| !deck.empty? }

puts calculate_score(winner)
