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

    def initialize(number, name = '', detail: false)
      BGPView::Number.check(number)

      @number = number
      @name = name
      @data = {}

      call_api if detail

      @@cache[number] = self
    end

    def self.find(number)
      @@cache.key?(number) ? @@cache[number] : new(number, detail: true)
    end

    def self.find_or_create(number, name)
      @@cache.key?(number) ? @@cache[number] : new(number, name)
    end

    def method_missing(method, *args)
      if data.key?(method.to_sym)
        data[method.to_sym]
      else
        super
      end
    end

    def upstreams
      BGPView::Upstreams.find(@number)
    end

    def downstreams
      BGPView::Downstreams.find(@number)
    end

    def peers
      BGPView::Peers.find(@number)
    end

    def prefixes
      BGPView::Prefixes.find(@number)
    end

    private

    def data
      call_api if @data.empty?
      @data
    end

    def call_api
      result = BGPView::API.call("asn/#{@number}")
      @name = result[:data][:name]
      @data = result[:data]
    end
  end
end
