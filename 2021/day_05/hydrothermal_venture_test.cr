require "spec"
require "./hydrothermal_venture"

describe HydrothermalVenture do
  it "finds solution for part 1" do
    HydrothermalVenture.new("test_input.txt").execute_one.should eq 5

    HydrothermalVenture.new("input.txt").execute_one.should eq 5632
  end

  it "finds solution for part 2" do
    HydrothermalVenture.new("test_input.txt").execute_two.should eq 12

    HydrothermalVenture.new("input.txt").execute_two.should eq 22213
  end
end
