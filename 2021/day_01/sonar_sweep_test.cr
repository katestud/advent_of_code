require "spec"
require "./sonar_sweep"

describe SonarSweep do
	it "finds solution for part 1" do
		SonarSweep.new("test_input.txt").execute_one.should eq 7

    SonarSweep.new("input.txt").execute_one.should eq 1292
	end

  it "finds solution for part 2" do
		SonarSweep.new("test_input.txt").execute_two.should eq 5

    SonarSweep.new("input.txt").execute_two.should eq 1262
	end
end
