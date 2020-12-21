INGREDIENT_MATCH = /(?<ingredients>.+)(\(contains\s)(?<allergens>.+)\)/

total_ingredients = []
possible_ingredients = {}

 File.readlines("input.txt", chomp: true).each do |line|
  match = line.match(INGREDIENT_MATCH)
  ingredients = match[:ingredients].split
  total_ingredients += ingredients
  match[:allergens].split(", ").each do |allergen|
    existing = possible_ingredients[allergen]
    if existing
      possible_ingredients[allergen] = existing & ingredients
    else
      possible_ingredients[allergen] = ingredients
    end
  end
end

puts possible_ingredients

all_possible_allergens = possible_ingredients.values.flatten
non_allergens = total_ingredients - all_possible_allergens

puts non_allergens.count

# Part 2
count = possible_ingredients.keys.count
ingredient_by_allergen = {}

until ingredient_by_allergen.keys.count == count
  ingredient, allergens = possible_ingredients.find { |k, v| v.length == 1 }
  ingredient_by_allergen[ingredient] = allergens.first
  possible_ingredients.transform_values! { |v| v - allergens }
end

puts ingredient_by_allergen

result = ingredient_by_allergen.keys.sort.map do |a|
  ingredient_by_allergen[a]
end.join(",")

puts result
