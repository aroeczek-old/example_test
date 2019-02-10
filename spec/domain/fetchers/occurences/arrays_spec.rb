require "rails_helper"

describe Fetchers::Occurences::Arrays do
  subject do
    -> { described_class.call(page_url: page_url, min_elements: min_elements, use_cache: false) }
  end

  let(:page_url) { 'http://openlibrary.org/search.json?q=the+lord+of+the+rings' }
  let(:cassette) { ActiveSupport::Inflector.parameterize(page_url, separator: '_') }

  let(:min_elements) { 10 }

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
    it 'returns correct number of arrays with more elements than #{described_class::MIN_NUMBER_OF_ELEMENTS}' do
      expect(@response.occurence).to eq 88
    end

    context 'when changed min number of elements' do
      let(:min_elements) { 1000 }

      it 'returns correct number of arrays with more elements than #{described_class::MIN_NUMBER_OF_ELEMENTS}' do
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
