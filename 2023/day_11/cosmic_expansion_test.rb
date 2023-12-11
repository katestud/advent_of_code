require "minitest/autorun"
require_relative "cosmic_expansion"

class CosmicExpansionTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 374, CosmicExpansion.new("test_input.txt").execute_one

    assert_equal 0, CosmicExpansion.new("input.txt").execute_one
  end

  def test_that_part_two_works
    assert_equal 0, CosmicExpansion.new("test_input.txt").execute_two

    # assert_equal 0, CosmicExpansion.new("input.txt").execute_two
  end
end
