module Api
  class BaseController < ApplicationController
    before_action :doorkeeper_authorize!

    def render_success(json = {})
      render json: json, status: :ok
    end

    def render_errors(json = {}, status: :unprocesable_entity)
      render json: { errors: json }, status: status
    end
  end
end
