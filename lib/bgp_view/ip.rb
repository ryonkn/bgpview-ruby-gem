# frozen_string_literal: true

module BGPView
  class Ip
    def initialize(data)
      @data = data
    end

    def method_missing(method, *args)
      return @data[method.to_sym] if @data.key?(method.to_sym)

      super
    end
  end
end
