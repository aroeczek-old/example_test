module Api
  class BaseController < ApplicationController
    def render_success(json = {})
      render json: json, status: :ok
    end
  end
end
