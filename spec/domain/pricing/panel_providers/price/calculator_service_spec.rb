require "rails_helper"

describe Pricing::PanelProviders::Price::CalculatorService do
  subject do
    -> { described_class.call(panel: panel, calculator: calculator) }
  end

  let(:panel)      { create :panel_provider, :panel_1 }
  let(:calculator) { nil }

  context 'when not passed intace of calculator in params' do
    let(:calculator_for_panel) { double() }

    before do
      allow(Pricing::PanelProviders::Price::Calculators::Factory).to receive(:call).with(panel) { calculator_for_panel }
    end

    it 'invokes correct calculator' do
      expect(calculator_for_panel).to receive(:call)

      subject.call
    end
  end

  context 'when passed intace of calculator in params' do
    let(:calculator) { Pricing::Calculators::NumberOfArrays }

    it 'invokes correct calculator' do
      expect(calculator).to receive(:call)

      subject.call
    end
  end
end
