module Api
  class BaseController < ApplicationController
    def render_success(json = {})
      render json: json, status: :ok
    end

    def render_errors(json = {}, status: :unprocesable_entity)
      render json: { errors: json }, status: status
    end
  end
end
