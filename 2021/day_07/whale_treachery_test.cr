require "spec"
require "./whale_treachery"

describe WhaleTreachery do
  it "finds solution for part 1" do
    WhaleTreachery.new("test_input.txt").execute_one.should eq 37

    WhaleTreachery.new("input.txt").execute_one.should eq 355521
  end

  it "finds solution for part 2" do
    WhaleTreachery.new("test_input.txt").execute_two.should eq 168

    WhaleTreachery.new("input.txt").execute_two.should eq 100148777
  end
end
