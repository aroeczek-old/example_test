module Api
  module Public
    class BaseController < ApplicationController
      skip_before_action :doorkeeper_authorize!
    end
  end
end
