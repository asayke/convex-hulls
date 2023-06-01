# frozen_string_literal: true

require "test/unit"
require_relative '..\..\lib\convex\hulls.rb'

class TestHulls < Test::Unit::TestCase
  def setup
    @algorithms = Convex::Hulls::Algorithms.new
  end

  test "test_jarvis_convex_hull" do
    points = [
      [0, 3],
      [2, 2],
      [1, 1],
      [2, 1],
      [3, 0],
      [0, 0],
      [3, 3]
    ]

    expected_hull = [
      [0, 3],
      [0, 0],
      [3, 0],
      [3, 3],
    ]

    assert_equal expected_hull, @algorithms.jarvis(points)
  end

  test "test_jarvis_convex_hull_empty" do
    points = [
      [0, 0],
      [1, 1],
    ]

    expected_hull = []

    assert_equal expected_hull, @algorithms.jarvis(points)
  end

end