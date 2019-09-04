# frozen_string_literal: true

RSpec.describe BGPView::Peers do # rubocop:disable Metrics/BlockLength
  let(:peers) { described_class.find(2515) }

  describe '.find' do
    it 'success', vcr: { cassette_name: 'peers' } do
      expect(peers).to be_instance_of(described_class)
    end
  end

  describe '#ipv4' do
    it 'was valid as number', vcr: { cassette_name: 'peers' } do
      expect(peers.ipv4.map(&:number)).to match_array(
        [2497, 2518, 4777, 6939, 7514, 8220, 17_639, 24_482, 25_152]
      )
    end

    it 'was valid as name', vcr: { cassette_name: 'peers' } do
      expect(peers.ipv4.map(&:name)).to match_array(
        ['APNIC-AS-X-BLOCK', 'APNIC-NSPIXP2-AS', 'COLT', 'CONVERGE-AS',
         'HURRICANE', 'IIJ', 'K-ROOT-SERVER', 'MEX', 'SGGS-AS-AP']
      )
    end
  end

  describe '#ipv6' do
    it 'was valid as number', vcr: { cassette_name: 'peers' } do
      expect(peers.ipv6.map(&:number)).to match_array(
        [2497, 2500, 2518, 6939, 7660, 8220, 17_639, 18_403, 24_482, 25_152]
      )
    end

    it 'was valid as name', vcr: { cassette_name: 'peers' } do
      expect(peers.ipv6.map(&:name)).to match_array(
        ['APAN-JP', 'APNIC-AS-X-BLOCK', 'APNIC-AS-X-BLOCK', 'COLT',
         'CONVERGE-AS', 'FPT-AS-AP', 'HURRICANE', 'IIJ', 'K-ROOT-SERVER',
         'SGGS-AS-AP']
      )
    end
  end
end
