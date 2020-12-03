require "spec"
require "./toboggan_trajectory"

describe Trajectory do

  describe "#finds_tree_count" do
    it "finds all the threes by moving to the right three and down one" do
      Trajectory.new("test_input.txt").traverse.should eq 7
    end
  end
end
