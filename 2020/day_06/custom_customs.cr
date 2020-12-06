class CustomCustoms

  @input : Array(String)

	def initialize(input_file = "input.txt")
    @input = File.read(input_file).split("\n\n")
  end

  def execute
    count = 0
    @input.each do |response|
      next if response.empty?
      r = response.gsub("\n") { "" }
      uniq = r.split(//).uniq
      count += uniq.size
    end
    count
  end

# This list represents answers from five groups:

# In the first group, everyone (all 1 person) answered "yes" to 3 questions: a, b, and c.
# In the second group, there is no question to which everyone answered "yes".
# In the third group, everyone answered yes to only 1 question, a. Since some people did not answer "yes" to b or c, they don't count.
# In the fourth group, everyone answered yes to only 1 question, a.
# In the fifth group, everyone (all 1 person) answered "yes" to 1 question, b.

  def execute_2
    count = 0
    @input.each do |response|
      next if response.empty?
      row_count = response.split("\n", remove_empty: true).size

      response.gsub("\n") { "" }.split(//).uniq.each do |char|
        count += 1 if response.count(char) == row_count
      end
    end
    count
  end

end
