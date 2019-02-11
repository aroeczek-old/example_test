require "rails_helper"

describe Pricing::PanelProviders::Price::Calculators::Factory do
  subject do
    -> { described_class.call(panel) }
  end

  let(:panel) { nil }

  context 'when passed uknow panel type' do
    let(:panel) { double(type: :unknow) }

    it 'raises an error' do
      expect{ subject.call }.to raise_error{ Exceptions::PricingErrors::UnknowCalculator }
    end
  end

  context 'when passed type of Panel_1' do
    let(:panel) { build_stubbed :panel_provider, :panel_1 }

    it 'returns correct calculator' do
      expect(subject.call).to eq Pricing::Calculators::Letters
    end
  end

  context 'when passed type of Panel_2' do
    let(:panel) { build_stubbed :panel_provider, :panel_2 }

    it 'returns correct calculator' do
      expect(subject.call).to eq Pricing::Calculators::HtmlNodes
    end
  end

  context 'when passed type of Panel_3' do
    let(:panel) { build_stubbed :panel_provider, :panel_3 }

    it 'returns correct calculator' do
      expect(subject.call).to eq Pricing::Calculators::NumberOfArrays
    end
  end
end
