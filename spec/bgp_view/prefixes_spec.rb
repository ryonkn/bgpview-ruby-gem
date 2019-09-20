# frozen_string_literal: true

RSpec.describe BGPView::Prefixes do # rubocop:disable Metrics/BlockLength
  let!(:asn) { BGPView::Asn.find_or_create(7511, 'SYNAPSE') }
  let!(:prefixes) { described_class.find(asn) }
  let!(:as7511_prefixes) do
    ['103.53.120.0/22', '110.92.32.0/19', '124.146.64.0/19',
     '124.146.96.0/19', '202.208.160.0/19', '202.95.32.0/19',
     '203.111.192.0/20', '203.140.160.0/20', '203.145.96.0/20',
     '203.147.112.0/20', '210.146.80.0/20', '210.237.32.0/19',
     '219.100.8.0/22']
  end

  describe '.find' do
    it 'success', vcr: { cassette_name: 'prefixes' } do
      expect(prefixes).to be_instance_of(described_class)
    end
  end

  describe '#ipv4' do
    it 'was valid prefixes', vcr: { cassette_name: 'prefixes' } do
      expect(prefixes.ipv4.map(&:prefix)).to match_array(as7511_prefixes)
    end
  end

  describe '#ipv6' do
    it 'was valid prefixes', vcr: { cassette_name: 'prefixes' } do
      expect(prefixes.ipv6.map(&:prefix)).to match_array(
        ['2401:c800::/32']
      )
    end
  end
end
