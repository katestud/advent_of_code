class MonkeyBusiness

  def initialize(file_name = "input.txt")
    @monkeys = read_file(file_name).map { |paragraph| Monkey.new(paragraph) }
  end

  def execute_one
    20.times do
      @monkeys.each do |monkey|
        monkey.items.length.times do
          item = monkey.items.shift
          new_item = monkey.evaluate_item(item)
          @monkeys[monkey.throw_to_monkey(new_item)].items << new_item
        end
      end
    end
    @monkeys.map(&:evaluated).max(2).reduce(:*)
  end

  def execute_two
    @monkeys.length
  end

  private

  def read_file(file_name)
    File.read(file_name, chomp: true).split("\n\n")
  end

end

# Monkey 0:
#   Starting items: 96, 60, 68, 91, 83, 57, 85
#   Operation: new = old * 2
#   Test: divisible by 17
#     If true: throw to monkey 2
#     If false: throw to monkey 5

class Monkey

  attr_reader :items, :evaluated

  def initialize(paragraph)
    index, items, operation, test_case, truthy, falsey = paragraph.split("\n")
    @evaluated = 0
    @items = items.split(":").last.split.map(&:to_i)
    @operation = operation.split(":").last
    @modulo = test_case.match(/divisible by (\d+)/)[1].to_i
    @truthy_monkey = truthy.match(/throw to monkey (\d+)/)[1].to_i
    @falsey_monkey = falsey.match(/throw to monkey (\d+)/)[1].to_i
  end

  def evaluate_item(item)
    @evaluated += 1
    old = item
    result = eval(@operation)
    result / 3
  end

  def throw_to_monkey(item)
    if item % @modulo == 0
      @truthy_monkey
    else
      @falsey_monkey
    end
  end
end
