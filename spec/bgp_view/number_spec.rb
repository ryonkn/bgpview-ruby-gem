# frozen_string_literal: true

RSpec.describe BGPView::Number do
  describe '.check' do
    context 'when AS Number ' do
      it 'is not Integer' do
        expect { described_class.check('String') }.to raise_error(
          BGPView::InvalidASNumber,
          'AS Number is only Integer'
        )
      end

      it 'is bigger Integer' do
        expect { described_class.check(4_294_967_296) }.to raise_error(
          BGPView::InvalidASNumber,
          'AS Number is 4 bytes'
        )
      end

      it 'is negative number' do
        expect { described_class.check(-1) }.to raise_error(
          BGPView::InvalidASNumber,
          'AS Number is 4 bytes'
        )
      end
    end

    it 'success' do
      expect(described_class.check(1)).to be true
    end
  end
end
