# frozen_string_literal: true

RSpec.describe BGPView::API do
  describe 'call' do
    it 'was valid ASN', vcr: { cassette_name: 'asn' } do
      expect(described_class.call('asn/7511')).to include(
        status: 'ok'
      )
    end

    it 'of invalid AS number was invalid',
       vcr: { cassette_name: 'api_invalid_as_number' } do
      expect { described_class.call('asn/-1') }.to raise_error(
        BGPView::ApiError, 'Could not find ASN'
      )
    end

    it 'of invalid url was invalid',
       vcr: { cassette_name: 'api_invalid_url' } do
      expect { described_class.call('dummy') }.to raise_error(
        BGPView::ApiError, 'Not Found'
      )
    end
  end
end
