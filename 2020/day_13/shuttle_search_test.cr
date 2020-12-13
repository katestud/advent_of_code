require "spec"
require "./shuttle_search"

describe ShuttleSearch do
  it "works" do
    input = "19,x,x,x,x,x,x,x,x,x,x,x,x,37,x,x,x,x,x,883,x,x,x,x,x,x,x,23,x,x,x,x,13,x,x,x,17,x,x,x,x,x,x,x,x,x,x,x,x,x,797,x,x,x,x,x,x,x,x,x,41,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,29"
    ShuttleSearch.new(input).find_start_time.should eq 1118684865113056
  end
end
