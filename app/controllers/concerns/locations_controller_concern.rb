module LocationsControllerConcern
  extend ActiveSupport::Concern

  included do
  end

  def index
    locations = Pricing::Finders::SimpleLocations.call(strong_params[:country_code])

    render_success ::Api::LocationSerializer.new(locations).serialized_json
  end

  private

  def strong_params
    params.permit(:country_code)
  end
end
