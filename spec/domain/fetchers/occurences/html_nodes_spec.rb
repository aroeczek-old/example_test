require "rails_helper"

describe Fetchers::Occurences::HtmlNodes do
  subject do
    -> { described_class.call(page_url: page_url) }
  end

  let(:page_url) { 'http://time.com' }
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
    it 'returns correct letter occurence' do
      expect(@response.occurence).to eq 83
    end
  end

  context 'when passed page does not exist' do
    let(:page_url) { 'https://www.invalid.page' }

    it 'returns success as false' do
      expect(@response.success).to be_falsy
    end
  end
end
