# frozen_string_literal: true

RSpec.describe BGPView::Upstreams do # rubocop:disable Metrics/BlockLength
  let(:find_upstreams) { described_class.find(2515) }

  describe '.find' do
    it 'success', vcr: { cassette_name: 'upstreams' } do
      expect(find_upstreams).to be_instance_of(described_class)
    end
  end

  describe '#ipv4' do
    it 'was valid as number', vcr: { cassette_name: 'upstreams' } do
      expect(find_upstreams.ipv4.map(&:number)).to match_array(
        [2518, 2497, 7514]
      )
    end

    it 'was valid as name', vcr: { cassette_name: 'upstreams' } do
      expect(find_upstreams.ipv4.map(&:name)).to match_array(
        ['APNIC-AS-X-BLOCK', 'IIJ', 'MEX']
      )
    end
  end

  describe '#ipv6' do
    it 'was valid as number', vcr: { cassette_name: 'upstreams' } do
      expect(find_upstreams.ipv6.map(&:number)).to match_array(
        [2518, 2497]
      )
    end

    it 'was valid as name', vcr: { cassette_name: 'upstreams' } do
      expect(find_upstreams.ipv6.map(&:name)).to match_array(
        ['APNIC-AS-X-BLOCK', 'IIJ']
      )
    end
  end
end
