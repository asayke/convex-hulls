require "test/unit"
require_relative '..\..\lib\convex\jarvis.rb'
require_relative '..\..\lib\convex\graham.rb'

class TestHulls < Test::Unit::TestCase
  def setup
    @jarvis = Convex::Hulls::Jarvis.new
    @graham = Convex::Hulls::Graham.new
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

    assert_equal expected_hull, @jarvis.jarvis(points)
  end

  test "test_jarvis_convex_hull_empty" do
    points = [
      [0, 0],
      [1, 1],
    ]

    expected_hull = []

    assert_equal expected_hull, @jarvis.jarvis(points)
  end

  test "test_graham_convex_hull" do
    points = [
      [0, 3],
      [1, 1],
      [2, 2],
      [4, 4],
      [0, 0],
      [1, 2],
      [3, 1],
      [3, 3],
    ]

    expected_hull = [
      [0, 3],
      [4, 4],
      [3, 1],
      [0, 0]
    ]

    assert_equal expected_hull, @graham.graham(points)
  end

  test "test_graham_convex_hull_empty" do
    points = [[0, 0], [1, 1]]
    assert_empty(@graham.graham(points))
  end

  test "test_graham_convex_hull_another" do
    points = [
      [1, 2],
      [3, 1],
      [5, 6],
    ]

    expected_hull = [
      [1, 2],
      [5, 6],
      [3, 1],
    ]

    assert_equal expected_hull, @graham.graham(points)
  end
end