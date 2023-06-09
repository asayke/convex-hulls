# Convex::Hulls

The Jarvis algorithm (or the Jarvis bypass algorithm, or the gift wrapping algorithm) determines the sequence of elements of a set forming a convex hull for this set. The method can be represented as a rope wrapping of a set of nails driven into the board. The algorithm works in time O(nh), where n is the total number of points on the plane,  h is the number of points in the convex hull.

Graham's algorithm is an algorithm for constructing a convex hull in two—dimensional space. In this algorithm, the convex hull problem is solved using a stack formed from candidate points. All points of the input set are entered into the stack, and then points that are not vertices of the convex hull are eventually removed from it. Upon completion of the algorithm, only the shell vertices remain in the glass in the order of their counterclockwise traversal.

## Installation

To install convex-hulls, you need to have Ruby installed on your computer. If Ruby is not installed yet, you can download it from the official website https://www.ruby-lang.org/en/downloads/.

After installing Ruby, you need to follow these steps:

> + Copy a repository writing ```$ git clone https://github.com/asayke/convex-hulls.git``` in folder of your choice 
> + Write ```$ gem build convex-hulls.gemspec```
> + Write ```$ gem install ./convex-hulls-x.x.x.gem``` (depending on your build version)

## Usage

To use Algorithms, you need to create an Algorithms class object and call its methods.

Jarvis algorithm :
```rb
@jarvis.jarvis(points)
```

Graham algorithm :
```rb
@graham.graham(points)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/asayke/convex-hulls. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/asayke/convex-hulls/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Convex::Hulls project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/asayke/convex-hulls/blob/master/CODE_OF_CONDUCT.md).
