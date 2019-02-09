module Validators
  module Schemas
    class EvaluateTargetParams < Base

      private

      def build_schema
        @schema ||= Dry::Validation.Schema do
          required(:country_code).filled(:str?)
          required(:target_group_id).filled(:int?)

          required(:locations).each do
            schema do
              required(:id).filled(:int?)
              required(:panel_size).filled(:int?)
            end
          end
        end
      end
    end
  end
end
