require 'rails_helper'

RSpec.describe Api::LocationsController, type: :controller do
  render_views

   describe 'GET #index' do
    subject { -> { get action, params: params } }

    let(:action)  { :index }
    let(:params)  { { country_code: country.code } }

    let(:country) { create :country, :with_location, code: 'country_code' }

    it_behaves_like 'endpoint that requires authentication'

    context 'when authenticated' do

      before do
        authenticated :web_app
        allow(Pricing::Finders::SimpleLocations).to receive(:call).with(country.code) { country.locations }

        subject.call
      end

      it_behaves_like 'success endpoint'

      it 'returns correct json' do
        expected_keys = %w(id name externalId createdAt)

        expect(json[:data].first[:attributes].keys).to match_array expected_keys
      end
    end
  end
end
