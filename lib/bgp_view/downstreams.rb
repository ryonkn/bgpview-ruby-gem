# frozen_string_literal: true

require 'bgp_view/api'

module BGPView
  class Downstreams
    @@cache = {}

    private_class_method :new
    attr_reader :ipv4, :ipv6

    def initialize(number)
      BGPView::Number.check(number)

      downstreams = BGPView::API.call("asn/#{number}/downstreams")

      @ipv4 = extract_as(downstreams, 'ipv4')
      @ipv6 = extract_as(downstreams, 'ipv6')

      @@cache[number] = self
    end

    def self.find(asn)
      @@cache.key?(asn.number) ? @@cache[asn.number] : new(asn.number)
    end

    private

    def extract_as(downstreams, version)
      downstreams[:data]["#{version}_downstreams".to_sym].map do |as|
        BGPView::Asn.find(as[:asn], as[:name], fetch: false)
      end
    end
  end
end
