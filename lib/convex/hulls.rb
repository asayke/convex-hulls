# frozen_string_literal: true

require_relative "hulls/version"

module Convex
  module Hulls
    class Error < StandardError; end

    class Algorithms
      def orientation(p, q, r)
        val = (q[1] - p[1]) * (r[0] - q[0]) - (q[0] - p[0]) * (r[1] - q[1])

        if val == 0
          return 0 # collinear
        elsif val > 0
          return 1 # clockwise
        else
          return 2 # counterclockwise
        end
      end

      def jarvis(points)
        n = points.size

        # There must be at least 3 points
        return [] if n < 3

        # Initialize Result
        hull = []

        # Find the leftmost point
        l = 0
        (1...n).each do |i|
          l = i if points[i][0] < points[l][0]
        end

        # Start from the leftmost point, keep moving counterclockwise
        # until reaching the start point again. This loop runs O(h)
        # times where h is the number of points in the result or output.
        p = l
        q = nil
        loop do
          # Add current point to result
          hull << points[p]

          # Search for a point 'q' such that orientation(p, q, x)
          # is counterclockwise for all points 'x'. The idea is to
          # keep track of the last visited most counterclockwise
          # point in q. If any point 'i' is more counterclockwise than q,
          # then update q.
          q = (p + 1) % n
          (0...n).each do |i|
            # If i is more counterclockwise than current q, then update q
            if orientation(points[p], points[i], points[q]) == 2
              q = i
            end
          end

          # Now q is the most counterclockwise with respect to p
          # Set p as q for the next iteration, so that q is added to the result 'hull'
          p = q

          break if p == l # While we don't come to the first point
        end

        return hull
      end
    end
  end
end
