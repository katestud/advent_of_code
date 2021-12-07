require "spec"
require "./whale_treachery"

describe WhaleTreachery do
  it "finds solution for part 1" do
    WhaleTreachery.new("test_input.txt").execute(1).should eq 37

    WhaleTreachery.new("input.txt").execute(1).should eq 355521
  end

  it "finds solution for part 2" do
    WhaleTreachery.new("test_input.txt").execute(2).should eq 168

    WhaleTreachery.new("input.txt").execute(2).should eq 100148777
  end
end
