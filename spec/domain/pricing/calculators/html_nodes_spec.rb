require "rails_helper"
#I'm aware of DRY in Calculator tests as further improvements can be extracted to the
#shared example  where will be passed correct fetcher instance and expected result value
describe Pricing::Calculators::HtmlNodes do
  subject do
    -> { described_class.call(html_nodes_number_fetcher: fetcher_instance) }
  end

  let(:fetcher)          { Struct.new(:occurence) }
  let(:fetcher_instance) { double(call: fetcher.new(50) ) }

  context 'whne passed correct fetcher instance' do
    it 'returns correct price' do
      expect(subject.call).to eq 0.5
    end
  end

  context 'when invalid fetcher instance passed' do
    let(:fetcher_instance) { nil }

    it 'raises an error' do
      expect{ subject.call }.to raise_error{ ArgumentError }
    end
  end
end
