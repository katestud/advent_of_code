require "spec"
require "./dive"

describe Dive do
  it "finds solution for part 1" do
    Dive.new("test_input.txt").execute_one.should eq 150

    Dive.new("input.txt").execute_one.should eq 1488669
  end

  it "finds solution for part 2" do
    Dive.new("test_input.txt").execute_two.should eq 900

    Dive.new("input.txt").execute_two.should eq 1176514794
  end
end
