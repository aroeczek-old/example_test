module Api
  class PanelsController < BaseController
    before_action :validate_target_params, only: [:evaluate_target]

    def evaluate_target
      data = Pricing::Locations::PriceEvaluatorService.call(location_ids: location_ids,
                                                            country_code: params[:country_code])
      render_success({ data: data.as_json })
    end

    private

    def location_ids
      params[:locations].pluck(:id)
    end

    def validate_target_params
      output = Validators::Schemas::EvaluateTargetParams.call(params.to_unsafe_h)

      return render_errors(output.errors.camelize_keys!, status: :bad_request) if output.errors.any?
    end
  end
end
