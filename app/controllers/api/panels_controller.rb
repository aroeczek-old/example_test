module Api
  class PanelsController < BaseController
    before_action :validate_target_params, only: [:evaluate_target]

    def evaluate_target
      response_modifier = Proc.new { |response| response.as_json }

      data = Pricing::Locations::PriceEvaluatorService.call(location_ids: location_ids,
                                                            country_code: params[:country_code],
                                                            &response_modifier)
      render_success data
    end

    private

    def location_ids
      params[:locations].pluck(:id)
    end

    def validate_target_params
      output = Validators::Schemas::EvaluateTargetParams.call(params.to_unsafe_h[:panel])

      return render_errors(output.errors, status: :bad_request) if output.errors.any?
    end
  end
end
