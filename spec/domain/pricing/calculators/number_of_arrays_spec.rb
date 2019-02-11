require "rails_helper"

describe Pricing::Calculators::NumberOfArrays do
  subject do
    -> { described_class.call(arrays_number_fetcher: fetcher_instance) }
  end

  let(:fetcher)          { Struct.new(:occurence) }
  let(:fetcher_instance) { double(call: fetcher.new(200) ) }

  context 'whne passed correct fetcher instance' do
    it 'returns correct price' do
      expect(subject.call).to eq 200
    end
  end

  context 'when invalid fetcher instance passed' do
    let(:fetcher_instance) { nil }

    it 'raises an error' do
      expect{ subject.call }.to raise_error{ ArgumentError }
    end
  end
end
