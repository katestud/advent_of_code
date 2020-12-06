require "spec"
require "./custom_customs"

describe CustomCustoms do
	it "works" do
    CustomCustoms.new("test_input.txt").execute.should eq 11

    CustomCustoms.new("input.txt").execute.should eq 6742
  end

  it "works for part 2" do
    CustomCustoms.new("test_input.txt").execute_2.should eq 6

    CustomCustoms.new("input.txt").execute_2.should eq 3447
	end
end
