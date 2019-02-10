class ApplicationController < ActionController::API
  before_action :doorkeeper_authorize!

  def current_app
    @current_app ||= Doorkeeper::Application.find(doorkeeper_token.resource_owner_id) if doorkeeper_token&.resource_owner_id
  end

  def render_success(json = {})
    render json: json, status: :ok
  end

  def render_errors(json = {}, status: :unprocesable_entity)
    render json: { errors: json }, status: status
  end
end
