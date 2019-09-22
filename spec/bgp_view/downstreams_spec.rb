# frozen_string_literal: true

RSpec.describe BGPView::Downstreams do # rubocop:disable Metrics/BlockLength
  let!(:asn) { BGPView::Asn.find_or_create(7511, 'SYNAPSE') }
  let!(:downstreams) { described_class.find(asn) }

  describe '.find' do
    it 'success', vcr: { cassette_name: 'downstreams' } do
      expect(downstreams).to be_instance_of(described_class)
    end
  end

  describe '#ipv4' do
    it 'was valid AS numbers', vcr: { cassette_name: 'downstreams' } do
      expect(downstreams.ipv4.map(&:number)).to match_array(
        [7517, 45_687]
      )
    end

    it 'was valid AS names', vcr: { cassette_name: 'downstreams' } do
      expect(downstreams.ipv4.map(&:name)).to match_array(
        %w[MCT-Internet MII]
      )
    end
  end

  describe '#ipv6' do
    it 'was valid AS numbers', vcr: { cassette_name: 'downstreams' } do
      expect(downstreams.ipv6.map(&:number)).to match_array(
        []
      )
    end

    it 'was valid AS names', vcr: { cassette_name: 'downstreams' } do
      expect(downstreams.ipv6.map(&:name)).to match_array(
        []
      )
    end
  end
end
