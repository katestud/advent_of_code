input = File.read("input.txt").split("\n\n")
deck_one, deck_two = input.map do |deck|
  deck.split("\n")[1..-1].map(&:to_i)
end

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

winner = deck_one.empty? ? deck_two : deck_one

score = winner.map.with_index do |card, index|
  (winner.length - index) * card
end.sum

puts score
