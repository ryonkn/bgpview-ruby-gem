# frozen_string_literal: true

require 'bgp_view/api'

module BGPView
  class Peers
    @@cache = {}

    private_class_method :new
    attr_reader :ipv4, :ipv6

    def initialize(number)
      BGPView::Number.check(number)

      peers = BGPView::API.call("asn/#{number}/peers")

      @ipv4 = extract_as(peers, 'ipv4')
      @ipv6 = extract_as(peers, 'ipv6')

      @@cache[number] = self
    end

    def self.find(asn)
      @@cache.key?(asn.number) ? @@cache[asn.number] : new(asn.number)
    end

    private

    def extract_as(peers, version)
      peers[:data]["#{version}_peers".to_sym].map do |as|
        BGPView::Asn.find(as[:asn], as[:name], fetch: false)
      end
    end
  end
end
