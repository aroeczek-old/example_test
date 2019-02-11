require "rails_helper"

describe Pricing::Calculators::Letters do
  subject do
    -> { described_class.call(leter_number_fetcher: fetcher_instance) }
  end

  let(:fetcher)          { Struct.new(:occurence) }
  let(:fetcher_instance) { double(call: fetcher.new(75) ) }

  context 'whne passed correct fetcher instance' do
    it 'returns correct price' do
      expect(subject.call).to eq 0.75
    end
  end

  context 'when invalid fetcher instance passed' do
    let(:fetcher_instance) { nil }

    it 'raises an error' do
      expect{ subject.call }.to raise_error{ ArgumentError }
    end
  end
end
