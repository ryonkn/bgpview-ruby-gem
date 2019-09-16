# frozen_string_literal: true

require 'bgp_view/version'
require 'bgp_view/asn'

module BGPView
  def self.asn(number = 0)
    BGPView::Asn.find(number)
  end
end
