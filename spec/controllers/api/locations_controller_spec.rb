require 'rails_helper'

RSpec.describe Api::LocationsController, type: :controller do
  render_views

   describe 'GET #index' do
    subject { -> { get action, params: params } }

    let(:action)  { :index }
    let(:params)  { {} }

    it_behaves_like 'endpoint that requires authentication'

    context 'when authenticated' do
      before do
      end
    end
  end
end
