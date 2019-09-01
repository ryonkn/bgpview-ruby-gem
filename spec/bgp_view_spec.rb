# frozen_string_literal: true

RSpec.describe BGPView do
  describe '.find' do
    it 'success', vcr: { cassette_name: 'asn' } do
      expect(described_class.find(2515)).to be_instance_of(BGPView::Asn)
    end
  end
end
