# frozen_string_literal: true

require 'httpclient'
require 'json'
require 'bgpview/error'

module BGPView
  class API
    API_BASE_URL = 'https://api.bgpview.io/asn/'

    def self.call(url)
      client = HTTPClient.new
      response = client.get("#{API_BASE_URL}#{url}")
      raise ApiError, response.reason if response.status != 200

      hash = JSON.parse(response.body, symbolize_names: true)
      raise ApiError, hash[:status_message] unless hash[:status] == 'ok'

      hash
    end
  end
end
