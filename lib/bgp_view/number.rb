# frozen_string_literal: true

require 'bgp_view/error'

module BGPView
  class Number
    def self.check(number)
      unless number.is_a? Integer
        raise InvalidASNumber, 'AS Number is only Integer'
      end
      if number.negative? || number >= 4_294_967_296
        raise InvalidASNumber, 'AS Number is 4 bytes'
      end

      true
    end
  end
end
