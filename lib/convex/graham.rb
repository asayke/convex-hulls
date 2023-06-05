require_relative "hulls/version"

module Convex
  module Hulls
    class Error < StandardError; end

    class Graham
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