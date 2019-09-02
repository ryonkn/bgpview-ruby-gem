# BGPView

[![Gem Version](https://badge.fury.io/rb/bgpview.svg)](https://badge.fury.io/rb/bgpview)
[![Build Status](https://travis-ci.org/ryonkn/bgpview-ruby-gem.svg)](https://travis-ci.org/ryonkn/bgpview-ruby-gem)
[![Coverage Status](https://coveralls.io/repos/github/ryonkn/bgpview-ruby-gem/badge.svg)](https://coveralls.io/github/ryonkn/bgpview-ruby-gem)

A Ruby wrapper for BGPView API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bgpview'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bgpview

## Usage

```ruby
require 'bgpview'

as2515 = BGPView.find(2515)
as2515.upstreams
as2515.peers
as2515.prefixes
```

## Contributing

1. Fork it ( https://github.com/ryonkn/bgpview-ruby-gem/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Bgpview project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ryonkn/bgpview/blob/master/CODE_OF_CONDUCT.md).
