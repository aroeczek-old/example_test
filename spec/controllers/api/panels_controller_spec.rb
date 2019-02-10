require 'rails_helper'

RSpec.describe Api::PanelsController, type: :controller do
  render_views

   describe 'POST #evaluate_target' do
    subject { -> { post action, params: params, as: :json } }

    let(:action)  { :evaluate_target }
    let(:params)  { { country_code: country_code,
                      target_group_id: 1,
                      locations: locatins_params } }

    let(:locatins_params) { [ { id: 1, panel_size: 200 } ] }
    let(:country_code)    { 'de' }

    let(:evaluator)      { Pricing::Locations::PriceEvaluatorService }
    let(:response_data)  { [ evaluator::Price.new(1, 20), evaluator::Price.new(1, 30)] }

    it_behaves_like 'endpoint that requires authentication'

    context 'when authenticated' do
      before do
        authenticated :web_app
        allow(evaluator).to receive(:call).with(*any_args) { response_data }

        subject.call
      end

      context 'when sent invalid params' do
        let(:country_code) { nil }

        it 'resposne with an 400 http status' do
          expect(response.status).to eq 400
        end

        it 'returns correct params validation errors' do
          expect(json[:errors].keys).to match_array %w(countryCode)
        end
      end

      context 'when sent valid params' do
        it_behaves_like 'success endpoint'

        it 'returns correct json' do
          expected_keys = %w(location_id price)

          expect(json[:data].first.keys).to match_array expected_keys
        end
      end
    end
  end
end
