# frozen_string_literal: true

require 'bgpview/version'
require 'bgpview/asn'

module BGPView
  def self.find(number = 0)
    BGPView::Asn.find(number)
  end
end
