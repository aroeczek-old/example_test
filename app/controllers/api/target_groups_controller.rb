module Api
  class TargetGroupsController < BaseController
    before_action :load_groups, only: [:index]

    def index
      render_success ::Api::TargetGroupSerializer.new(@target_roups).serialized_json
    end

    private

    def strong_params
      params.permit(:country_code)
    end

    def load_groups
      #If the search will be more sophisticated I woul do similar finder service like Finders::SimpleLocations
      @target_roups = if strong_params.dig(:country_code).blank?
        TargetGroup.all
      else
        TargetGroup.by_country_code(strong_params[:country_code])
      end
    end
  end
end
