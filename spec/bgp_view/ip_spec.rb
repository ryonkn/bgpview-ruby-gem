# frozen_string_literal: true

RSpec.describe BGPView::Ip do
  let(:ip) do
    described_class.new(
      prefix: '192.0.2.0/24', ip: '192.0.2.0', cidr: 24
    )
  end

  describe '#prefix' do
    it 'was valid' do
      expect(ip.prefix).to eq('192.0.2.0/24')
    end
  end

  describe '#ip' do
    it 'was valid' do
      expect(ip.ip).to eq('192.0.2.0')
    end
  end

  describe '#cidr' do
    it 'was valid' do
      expect(ip.cidr).to eq(24)
    end
  end

  describe '#method_missing' do
    it 'of not member was invalid' do
      expect { ip.country }.to raise_error(NoMethodError)
    end
  end
end
