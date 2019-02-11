require "rails_helper"

describe Pricing::Finders::SimpleLocations do
  subject do
    -> { described_class.call(code) }
  end

  let(:code) { country.code }

  let!(:location)       { create :location }
  let!(:other_location) { create :location }

  let!(:country) { create :country, :with_location, location: location }

  context 'whne passed country code' do
    context 'when locations for country exists' do
      it 'responds with filtered locations' do
        expect(subject.call).to match_array [location]
      end
    end

    context 'when there is no location for passed contry code' do
      let(:code) { :none_existing }

      it 'responds with empty locations' do
        expect(subject.call).to be_empty
      end
    end
  end

  context 'when not passed country code' do
    let(:code) { nil }

    it 'returns all locations' do
      expect(subject.call).to match_array [location, other_location]
    end
  end
end
