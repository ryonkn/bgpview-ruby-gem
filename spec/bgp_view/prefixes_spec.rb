# frozen_string_literal: true

RSpec.describe BGPView::Prefixes do
  let(:prefixes) { described_class.find(2515) }

  describe '.find' do
    it 'success', vcr: { cassette_name: 'prefixes' } do
      expect(prefixes).to be_instance_of(described_class)
    end
  end

  describe '#ipv4' do
    it 'was valid prefix', vcr: { cassette_name: 'prefixes' } do
      expect(prefixes.ipv4.map(&:prefix)).to match_array(
        ['103.131.194.0/23', '192.41.192.0/24', '202.12.30.0/24',
         '211.120.240.0/21']
      )
    end
  end

  describe '#ipv6' do
    it 'was valid prefix', vcr: { cassette_name: 'prefixes' } do
      expect(prefixes.ipv6.map(&:prefix)).to match_array(
        ['2001:dc2::/32', '2001:fa0::/32']
      )
    end
  end
end
