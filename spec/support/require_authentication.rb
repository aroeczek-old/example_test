RSpec.shared_examples 'endpoint that requires authentication' do |request_method, action, params = {}|
  before do
    subject&.call || send(request_method, action, params: params)
  end

  it 'responds with 401 HTTP status code' do
    expect(response).to have_http_status :unauthorized
  end
end
