# frozen_string_literal: true

require 'bgp_view/api'
require 'bgp_view/ip'

module BGPView
  class Prefixes
    @@cache = {}

    private_class_method :new
    attr_reader :ipv4, :ipv6

    def initialize(number)
      BGPView::Number.check(number)

      prefixes = BGPView::API.call("asn/#{number}/prefixes")

      @ipv4 = extract_ip(prefixes, 'ipv4')
      @ipv6 = extract_ip(prefixes, 'ipv6')

      @@cache[number] = self
    end

    def self.find(number)
      @@cache.key?(number) ? @@cache[number] : new(number)
    end

    private

    def extract_ip(prefixes, version)
      prefixes[:data]["#{version}_prefixes".to_sym].map do |prefix|
        BGPView::Ip.new(prefix)
      end
    end
  end
end
