# frozen_string_literal: true

require 'bgp_view/api'

module BGPView
  class Upstreams
    @@cache = {}

    private_class_method :new
    attr_reader :ipv4, :ipv6

    def initialize(number)
      BGPView::Number.check(number)

      upstreams = BGPView::API.call("asn/#{number}/upstreams")

      @ipv4 = extract_as(upstreams, 'ipv4')
      @ipv6 = extract_as(upstreams, 'ipv6')

      @@cache[number] = self
    end

    def self.find(number)
      @@cache.key?(number) ? @@cache[number] : new(number)
    end

    private

    def extract_as(upstreams, version)
      upstreams[:data]["#{version}_upstreams".to_sym].map do |as|
        BGPView::Asn.find_or_create(as[:asn], as[:name])
      end
    end
  end
end
