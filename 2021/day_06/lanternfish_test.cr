require "spec"
require "./lanternfish"

describe Lanternfish do
  it "finds solution for part 1" do
    Lanternfish.new("test_input.txt").execute_one.should eq 5934

    Lanternfish.new("input.txt").execute_one.should eq 0
  end

  it "finds solution for part 2" do
    Lanternfish.new("test_input.txt").execute_two.should eq 0

    # Lanternfish.new("input.txt").execute_two.should eq 0
  end
end
