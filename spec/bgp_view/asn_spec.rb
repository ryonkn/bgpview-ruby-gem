# frozen_string_literal: true

RSpec.describe BGPView::Asn do # rubocop:disable Metrics/BlockLength
  before { described_class.class_variable_set :@@cache, {} }

  let(:find_as) { described_class.find(7511) }
  let!(:find_or_create_as) { described_class.find_or_create(7511, 'SYNAPSE') }

  describe '.find' do
    it 'success', vcr: { cassette_name: 'asn' } do
      expect(find_as).to be_instance_of(described_class)
    end
  end

  describe '.find_or_create' do
    it 'success' do
      expect(find_or_create_as).to be_instance_of(described_class)
    end

    it 'was valid AS number' do
      expect(find_or_create_as.number).to eq(7511)
    end

    it 'was valid name' do
      expect(find_or_create_as.name).to eq('SYNAPSE')
    end
  end

  describe '#name' do
    it 'was valid', vcr: { cassette_name: 'asn' } do
      expect(find_as.name).to eq('SYNAPSE')
    end
  end

  describe '#number' do
    it 'was valid', vcr: { cassette_name: 'asn' } do
      expect(find_as.number).to eq(7511)
    end
  end

  describe '#method_missing' do
    it 'of country_code was valid', vcr: { cassette_name: 'asn' } do
      expect(find_as.country_code).to eq('JP')
    end

    it 'of not member was invalid', vcr: { cassette_name: 'asn' } do
      expect { find_as.country }.to raise_error(NoMethodError)
    end
  end

  describe '#upstreams' do
    it 'success', vcr: { cassette_name: 'asn' } do
      VCR.use_cassette 'upstreams' do
        expect(find_as.upstreams).to be_instance_of(BGPView::Upstreams)
      end
    end
  end

  describe '#downstreams' do
    it 'success', vcr: { cassette_name: 'asn' } do
      VCR.use_cassette 'downstreams' do
        expect(find_as.downstreams).to be_instance_of(BGPView::Downstreams)
      end
    end
  end

  describe '#peers' do
    it 'success', vcr: { cassette_name: 'asn' } do
      VCR.use_cassette 'peers' do
        expect(find_as.peers).to be_instance_of(BGPView::Peers)
      end
    end
  end

  describe '#prefixes' do
    it 'success', vcr: { cassette_name: 'asn' } do
      VCR.use_cassette 'prefixes' do
        expect(find_as.prefixes).to be_instance_of(BGPView::Prefixes)
      end
    end
  end
end
