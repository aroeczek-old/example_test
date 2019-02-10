require "rails_helper"

describe Pricing::Locations::PriceEvaluatorService do
  subject do
    -> { described_class.call(location_ids: location_ids,
                              country_code: country_code) }
  end

  let(:location_ids)       { Array.new }
  let(:country_code)       { country.code }
  let(:calculator_service) { Pricing::PanelProviders::Price::CalculatorService }

  let!(:panel_1) { create :panel_provider, :panel_1 }
  let!(:panel_2) { create :panel_provider, :panel_2 }

  let!(:country)       { create :country, code: :en, panel_provider: panel_2 }
  let!(:other_country) { create :country, code: :pl, panel_provider: panel_1 }

  before do
    allow(calculator_service).to receive(:call).with(panel: instance_of(Panels::Panel_2)) { 58.67 }
    allow(calculator_service).to receive(:call).with(panel: instance_of(Panels::Panel_1)) { 20 }
  end

  context 'when all location belong to passed country' do
    let!(:location)       { create :location, :with_country, country: country }
    let!(:other_location) { create :location, :with_country, country: country }
    let(:location_ids)    { [ location.id, other_location.id ] }

    it 'returns correctly calculated prices' do
      response = subject.call
      expected_prices = [ described_class::Price.new(other_location.id, 58.67),
                          described_class::Price.new(location.id, 58.67)]

      expect(response).to match_array expected_prices
    end
  end

  context 'when country does not exist' do
    let(:country_code) { :invalid }

    it 'resposnd with empty prices' do
      response = subject.call

      expect(response).to be_empty
    end
  end

  context 'when some location not belongs to the country' do
    let!(:location)       { create :location, :with_country, country: country }
    let!(:other_location) { create :location, :with_country, country: other_country }
    let(:location_ids)    { [ location.id, other_location.id ] }

    it 'returns correctly calculated prices' do
      response = subject.call
      expected_prices = [ described_class::Price.new(other_location.id, nil),
                          described_class::Price.new(location.id, 58.67)]

      expect(response).to match_array expected_prices
    end
  end
end
