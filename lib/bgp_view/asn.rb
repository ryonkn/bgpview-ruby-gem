# frozen_string_literal: true

require 'bgp_view/api'
require 'bgp_view/upstreams'
require 'bgp_view/downstreams'
require 'bgp_view/peers'
require 'bgp_view/prefixes'
require 'bgp_view/number'

module BGPView
  class Asn
    @@cache = {}

    private_class_method :new
    attr_reader :number, :name

    def initialize(number, name = '', fetch: false)
      BGPView::Number.check(number)

      @number = number
      @name = name
      @data = {}

      fetch_data if fetch

      @@cache[number] = self
    end

    def self.find(number, name = '', fetch: true)
      @@cache.key?(number) ? @@cache[number] : new(number, name, fetch: fetch)
    end

    def method_missing(method, *args)
      return data[method.to_sym] if data.key?(method.to_sym)

      super
    end

    def upstreams
      BGPView::Upstreams.find(self)
    end

    def downstreams
      BGPView::Downstreams.find(self)
    end

    def peers
      BGPView::Peers.find(self)
    end

    def prefixes
      BGPView::Prefixes.find(self)
    end

    private

    def data
      fetch_data if @data.empty?
      @data
    end

    def fetch_data
      result = BGPView::API.call("asn/#{@number}")
      @name = result[:data][:name]
      @data = result[:data]
    end
  end
end
