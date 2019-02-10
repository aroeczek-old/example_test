RSpec.shared_examples 'success endpoint' do |request_method, action, params = {}|
  before do
    unless response&.sent?
      subject&.call || send(request_method, action, params: params)
    end
  end

  it "responds with 200 HTTP status code" do
    expect(response).to have_http_status :ok
  end
end
