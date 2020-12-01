require "spec"
require "./report_repair"

describe Report do

  describe "#find_product" do
    it "multiplies the two items that sum to 2020" do
      product = Report.new("test_input.txt").find_product
      product.should eq 514579
    end
  end

  describe "#find_triple_product" do
    it "multiplies the two items that sum to 2020" do
      product = Report.new("test_input.txt").find_triple_product
      product.should eq 241861950
    end
  end
end
