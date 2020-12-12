require "spec"
require "./rain_risk"

describe RainRisk do
	it "part 1 finds the manhatttan distance" do
    RainRisk.new("test_input.txt").manhattan_distance.should eq 25

    RainRisk.new("input.txt").manhattan_distance.should eq 364
  end

  it "moves the ship relative to the waypoint" do
    RainRisk.new("test_input.txt").manhattan_distance_waypoint.should eq 286

    RainRisk.new("input.txt").manhattan_distance_waypoint.should eq 39518
	end
end
