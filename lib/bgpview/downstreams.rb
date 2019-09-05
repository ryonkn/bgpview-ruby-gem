# frozen_string_literal: true

require 'bgpview/api'

module BGPView
  class Downstreams
    @@cache = {}

    private_class_method :new
    attr_reader :ipv4, :ipv6

    def initialize(number)
      BGPView::Number.check(number)

      downstreams = BGPView::API.call("#{number}/downstreams")

      @ipv4 = extract_as(downstreams, 'ipv4')
      @ipv6 = extract_as(downstreams, 'ipv6')

      @@cache[number] = self
    end

    def self.find(number)
      @@cache.key?(number) ? @@cache[number] : new(number)
    end

    private

    def extract_as(downstreams, version)
      downstreams[:data]["#{version}_downstreams".to_sym].map do |as|
        BGPView::Asn.find_or_create(as[:asn], as[:name])
      end
    end
  end
end
