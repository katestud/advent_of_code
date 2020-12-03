require "spec"
require "./toboggan_trajectory"

describe Trajectory do

  describe "#finds_tree_count" do
    it "finds all the trees by moving to the right three and down one" do
      Trajectory.new("test_input.txt").traverse.should eq 7
    end
  end

  describe "#compares all routes" do
    it "compares multiple routes and returns the product of the trees" do
      Trajectory.new("test_input.txt").optimize.should eq 336
    end
  end
end
