# BGPView

[![Gem Version](https://badge.fury.io/rb/bgpview.svg)](https://badge.fury.io/rb/bgpview)
[![Build Status](https://travis-ci.org/ryonkn/bgpview-ruby-gem.svg)](https://travis-ci.org/ryonkn/bgpview-ruby-gem)
[![Coverage Status](https://coveralls.io/repos/github/ryonkn/bgpview-ruby-gem/badge.svg?branch=master)](https://coveralls.io/github/ryonkn/bgpview-ruby-gem?branch=master)
[![Maintainability](https://api.codeclimate.com/v1/badges/733fa73152c49837d658/maintainability)](https://codeclimate.com/github/ryonkn/bgpview-ruby-gem/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/733fa73152c49837d658/test_coverage)](https://codeclimate.com/github/ryonkn/bgpview-ruby-gem/test_coverage)

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
```

### ASN
```ruby
as7511 = BGPView.find(7511)       # BGPView::Asn instance
as7511.name                       # => "SYNAPSE"
as7511.website                    # => "https://www.synapse.jp"
as7511.traffic_estimation         # => "5-10Gbps"
```

### ASN Prefixes
```ruby
prefixes = as7511.prefixes        # BGPView::Prefixes instance
prefixes.ipv4                     # array of IPv4 prefixes
prefixes.ipv6                     # array of IPv6 prefixes
prefixes.ipv4.map(&:prefix)       # => ["103.53.120.0/22", "110.92.32.0/19", ...]
prefixes.ipv6.map(&:prefix)       # => ["2401:c800::/32"]
```

### ASN Peers
```ruby
peers = as7511.prefixes           # BGPView::Peers instance
peers.ipv4                        # array of IPv4 peers BGPView::Asn instances
peers.ipv6                        # array of IPv6 peers BGPView::Asn instances
peers.ipv4.map(&:number)          # => [7514, 8220, 17676, 45687, 24482, 7517, 4637, 6939, 23815, 64050]
peers.ipv6.map(&:name             # => ["HURRICANE", "MEX", "SGGS-AS-AP", "GIGAINFRA", "COLT", "FPT-AS-AP"]
```

### ASN Upstreams
```ruby
upstreams = as7511.upstreams      # BGPView::Upstreams instance
upstreams.ipv4                    # array of IPv4 upstream instances
upstreams.ipv6                    # array of IPv6 upstream instances
upstreams.ipv4.map(&:number)      # => [7514, 17676]
upstreams.ipv6.map(&:name)        # => ["MEX", "GIGAINFRA"]
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
