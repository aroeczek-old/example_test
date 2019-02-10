class ApplicationController < ActionController::API
  def current_app
    @current_app ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token&.resource_owner_id
  end
end
