# frozen_string_literal: true

RSpec.describe BGPView do
  describe '.asn' do
    it 'success', vcr: { cassette_name: 'asn' } do
      expect(described_class.asn(7511)).to be_instance_of(BGPView::Asn)
    end
  end
end
