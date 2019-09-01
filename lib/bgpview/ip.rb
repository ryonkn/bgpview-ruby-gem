# frozen_string_literal: true

module BGPView
  class Ip
    def initialize(data)
      @data = data
    end

    def method_missing(method, *args)
      if @data.key?(method.to_sym)
        @data[method.to_sym]
      else
        super
      end
    end
  end
end
