require_relative "hulls/version"

module Convex
  module Hulls
    class Error < StandardError; end

    class Jarvis
      def orientation(p, q, r)
        val = (q[1] - p[1]) * (r[0] - q[0]) - (q[0] - p[0]) * (r[1] - q[1])

        if val == 0
          0
        elsif val > 0
          return 1
        else
          2
        end
      end

      def jarvis(points)
        n = points.size

        return [] if n < 3

        hull = []

        l = 0
        (1...n).each do |i|
          l = i if points[i][0] < points[l][0]
        end

        p = l
        q = nil
        loop do
          hull << points[p]

          q = (p + 1) % n
          (0...n).each do |i|
            if orientation(points[p], points[i], points[q]) == 2
              q = i
            end
          end

          p = q

          break if p == l
        end

        hull
      end
    end
  end
end