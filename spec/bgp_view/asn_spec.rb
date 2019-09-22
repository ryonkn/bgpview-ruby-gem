# frozen_string_literal: true

RSpec.describe BGPView::Asn do # rubocop:disable Metrics/BlockLength
  before { described_class.class_variable_set :@@cache, {} }

  let(:asn) { described_class.find(7511) }
  let!(:create_asn) { described_class.find(7511, 'SYNAPSE', fetch: false) }

  describe '.find' do
    context 'when access api' do
      it 'success', vcr: { cassette_name: 'asn' } do
        expect(asn).to be_instance_of(described_class)
      end
    end

    context 'when not access api' do
      it 'success' do
        expect(create_asn).to be_instance_of(described_class)
      end

      it 'was valid AS number' do
        expect(create_asn.number).to eq(7511)
      end

      it 'was valid name' do
        expect(create_asn.name).to eq('SYNAPSE')
      end
    end
  end

  describe '#name' do
    it 'was valid', vcr: { cassette_name: 'asn' } do
      expect(asn.name).to eq('SYNAPSE')
    end
  end

  describe '#number' do
    it 'was valid', vcr: { cassette_name: 'asn' } do
      expect(asn.number).to eq(7511)
    end
  end

  describe '#method_missing' do
    it 'of country_code was valid', vcr: { cassette_name: 'asn' } do
      expect(asn.country_code).to eq('JP')
    end

    it 'of not member was invalid', vcr: { cassette_name: 'asn' } do
      expect { asn.country }.to raise_error(NoMethodError)
    end
  end

  describe '#upstreams' do
    it 'success', vcr: { cassette_name: 'asn' } do
      VCR.use_cassette 'upstreams' do
        expect(asn.upstreams).to be_instance_of(BGPView::Upstreams)
      end
    end
  end

  describe '#downstreams' do
    it 'success', vcr: { cassette_name: 'asn' } do
      VCR.use_cassette 'downstreams' do
        expect(asn.downstreams).to be_instance_of(BGPView::Downstreams)
      end
    end
  end

  describe '#peers' do
    it 'success', vcr: { cassette_name: 'asn' } do
      VCR.use_cassette 'peers' do
        expect(asn.peers).to be_instance_of(BGPView::Peers)
      end
    end
  end

  describe '#prefixes' do
    it 'success', vcr: { cassette_name: 'asn' } do
      VCR.use_cassette 'prefixes' do
        expect(asn.prefixes).to be_instance_of(BGPView::Prefixes)
      end
    end
  end
end
