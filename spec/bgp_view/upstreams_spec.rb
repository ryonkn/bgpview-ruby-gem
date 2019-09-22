# frozen_string_literal: true

RSpec.describe BGPView::Upstreams do # rubocop:disable Metrics/BlockLength
  let!(:asn) { BGPView::Asn.find_or_create(7511, 'SYNAPSE') }
  let!(:upstreams) { described_class.find(asn) }

  describe '.find' do
    it 'success', vcr: { cassette_name: 'upstreams' } do
      expect(upstreams).to be_instance_of(described_class)
    end
  end

  describe '#ipv4' do
    it 'was valid AS numbers', vcr: { cassette_name: 'upstreams' } do
      expect(upstreams.ipv4.map(&:number)).to match_array(
        [7514, 17_676]
      )
    end

    it 'was valid AS names', vcr: { cassette_name: 'upstreams' } do
      expect(upstreams.ipv4.map(&:name)).to match_array(
        %w[GIGAINFRA MEX]
      )
    end
  end

  describe '#ipv6' do
    it 'was valid AS numbers', vcr: { cassette_name: 'upstreams' } do
      expect(upstreams.ipv6.map(&:number)).to match_array(
        [7514, 17_676]
      )
    end

    it 'was valid AS names', vcr: { cassette_name: 'upstreams' } do
      expect(upstreams.ipv6.map(&:name)).to match_array(
        %w[GIGAINFRA MEX]
      )
    end
  end
end
