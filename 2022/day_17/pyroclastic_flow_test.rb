require "minitest/autorun"
require_relative "pyroclastic_flow"

class PyroclasticFlowTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 3068, PyroclasticFlow.new("test_input.txt").execute_one

    assert_equal 3149, PyroclasticFlow.new("input.txt").execute_one
  end

  def test_that_part_two_works
    # assert_equal 0, PyroclasticFlow.new("test_input.txt").execute_two

    # assert_equal 0, PyroclasticFlow.new("input.txt").execute_two
  end
end
