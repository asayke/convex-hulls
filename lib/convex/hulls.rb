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

      def next_to_top(stack)
        p = stack.pop
        res = stack[-1]
        stack.push(p)
        res
      end

      def swap(p1, p2)
        temp = p1
        p1 = p2
        p2 = temp
      end

      def dist_sq(p1, p2)
        (p1[0] - p2[0]) ** 2 + (p1[1] - p2[1]) ** 2
      end

      def compare(p1, p2)
        o = orientation($p0, p1, p2)
        return -1 if o == 0 && dist_sq($p0, p2) >= dist_sq($p0, p1)
        o == 2 ? -1 : 1
      end

      def graham(points)
        n = points.length

        ymin = points[0][1]
        min_index = 0
        (1...n).each do |i|
          y = points[i][1]
          if y < ymin || (ymin == y && points[i][0] < points[min_index][0])
            ymin = y
            min_index = i
          end
        end

        points[0], points[min_index] = points[min_index], points[0]

        $p0 = points[0]
        points[1..-1] = points[1..-1].sort { |p1, p2| compare(p1, p2) }

        m = 1
        (1...n).each do |i|
          while i < n - 1 && orientation($p0, points[i], points[i + 1]) == 0
            i += 1
          end
          points[m] = points[i]
          m += 1
        end

        return [] if m < 3

        stack = []
        stack.push(points[0])
        stack.push(points[1])
        stack.push(points[2])

        (3...m).each do |i|
          while stack.length > 1 && orientation(next_to_top(stack), stack[-1], points[i]) != 2
            stack.pop
          end
          stack.push(points[i])
        end

        stack.reverse
      end
    end
  end
end
