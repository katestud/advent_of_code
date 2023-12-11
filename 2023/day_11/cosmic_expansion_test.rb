require "minitest/autorun"
require_relative "cosmic_expansion"

class CosmicExpansionTest < Minitest::Test

  def test_that_part_one_works
    assert_equal 374, CosmicExpansion.new("test_input.txt").execute

    assert_equal 9974721, CosmicExpansion.new("input.txt").execute
  end

  def test_that_part_two_works
    assert_equal 1030, CosmicExpansion.new("test_input.txt", 10).execute
    assert_equal 8410, CosmicExpansion.new("test_input.txt", 100).execute

    assert_equal 702770569197, CosmicExpansion.new("input.txt", 1000000).execute
  end
end
