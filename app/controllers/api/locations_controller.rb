module Api
  class LocationsController < BaseController
    def index
      locations = Pricing::Finders::SimpleLocations.call(strong_params)

      render_success ::Api::LocationSerializer.new(locations).serialized_json
    end

    private

    def strong_params
      params.permit(:country_code)
    end
  end
end
