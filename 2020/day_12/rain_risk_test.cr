require "spec"
require "./rain_risk"

describe RainRisk do
	it "finds the manhatttan distance" do
    RainRisk.new("test_input.txt").manhattan_distance.should eq 25

    RainRisk.new("input.txt").manhattan_distance.should eq 364
	end
end
