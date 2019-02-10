require 'rails_helper'

RSpec.describe Api::TargetGroupsController, type: :controller do
  render_views

   describe 'GET #index' do
    subject { -> { get action, params: params } }

    let(:action)  { :index }
    let(:params)  { { country_code: country_code } }

    let(:country_code) { nil }

    let(:country)             { create :country, code: 'c_code' }
    let!(:target_group)       { create :target_group, :with_country, country: country }
    let!(:other_target_group) { create :target_group, :with_country }

    it_behaves_like 'endpoint that requires authentication'

    context 'when authenticated' do

      before do
        authenticated :web_app

        subject.call
      end

      shared_examples 'corret json attributes' do
        it 'returns correct json' do
          expected_keys = %w(id name externalId createdAt)

          expect(json[:data].first[:attributes].keys).to match_array expected_keys
        end
      end

      context 'when not sent country code param' do
        it_behaves_like 'success endpoint'
        it_behaves_like 'corret json attributes'

        it 'returns all target groups' do
          expected_ids = [target_group.id, other_target_group.id]

          expect(extract_ids).to match_array expected_ids
        end
      end

      context 'when sent country code param' do
        let(:country_code) { country.code }

        it_behaves_like 'success endpoint'
        it_behaves_like 'corret json attributes'

        it 'return target groups only for passed country code' do
          expected_ids = [target_group.id]

          expect(extract_ids).to match_array expected_ids
        end
      end
    end
  end

  private

  def extract_ids
    json[:data].pluck(:attributes).pluck(:id)
  end
end
