# frozen_string_literal: true

RSpec.describe BGPView::Peers do # rubocop:disable Metrics/BlockLength
  let!(:asn) { BGPView::Asn.find_or_create(7511, 'SYNAPSE') }
  let!(:peers) { described_class.find(asn) }

  describe '.find' do
    it 'success', vcr: { cassette_name: 'peers' } do
      expect(peers).to be_instance_of(described_class)
    end
  end

  describe '#ipv4' do
    it 'was valid AS numbers', vcr: { cassette_name: 'peers' } do
      expect(peers.ipv4.map(&:number)).to match_array(
        [4637, 6939, 7514, 7517, 8220, 17_676, 23_815, 24_482, 45_687, 64_050]
      )
    end

    it 'was valid AS names', vcr: { cassette_name: 'peers' } do
      expect(peers.ipv4.map(&:name)).to match_array(
        %w[ASN-TELSTRA-GLOBAL BCPL-SG COLT GIGAINFRA HURRICANE
           JPIX-RS MCT-Internet MEX MII SGGS-AS-AP]
      )
    end
  end

  describe '#ipv6' do
    it 'was valid AS numbers', vcr: { cassette_name: 'peers' } do
      expect(peers.ipv6.map(&:number)).to match_array(
        [6939, 7514, 8220, 17_676, 18_403, 24_482]
      )
    end

    it 'was valid AS names', vcr: { cassette_name: 'peers' } do
      expect(peers.ipv6.map(&:name)).to match_array(
        %w[COLT FPT-AS-AP GIGAINFRA HURRICANE MEX SGGS-AS-AP]
      )
    end
  end
end
