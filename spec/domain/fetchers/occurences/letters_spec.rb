require "rails_helper"

describe Fetchers::Occurences::Letters do
  subject do
    -> { described_class.call(page_url: page_url, letter_to_count: letter) }
  end

  let(:page_url) { 'http://time.com' }
  let(:letter)   { 'A' }
  let(:cassette) { ActiveSupport::Inflector.parameterize(page_url, separator: '_') }

  after :all do
    VCR.turn_off!
  end

  before do
    VCR.turn_on!
    VCR.use_cassette cassette do
      @response = subject.call
    end
  end

  context 'when passed page exists' do
    context 'when letter occures on page' do
      it 'returns correct letter occurence' do
        expect(@response.occurence).to eq 7
      end
    end

    context 'when letter does not occure on page' do
      let(:page_url) { 'https://www.google.pl/' }
      let(:letter)   { 'X' }

      it 'returns correct letter occurence' do
        expect(@response.occurence).to eq 0
      end
    end
  end

  context 'when passed page does not exist' do
    let(:page_url) { 'https://www.invalid.page' }

    it 'returns success as false' do
      expect(@response.success).to be_falsy
    end
  end
end
