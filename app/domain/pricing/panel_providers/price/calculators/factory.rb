module Pricing
  module PanelProviders
    module Price
      module Calculators
        class Factory
          def initialize(panel)
            @panel = panel
          end

          def self.call(panel)
            raise ArgumentError unless panel

            new(panel).call
          end

          def call
            panel_calculator_mappings[panel.class.name] || unknown_calculator
          end

          private

          attr_reader :panel

          def panel_calculator_mappings
            @calculator_mapping ||= {
              'Panels::Panel_1': ::Pricing::Calculators::Letters,
              'Panels::Panel_2': ::Pricing::Calculators::HtmlNodes,
              'Panels::Panel_3': ::Pricing::Calculators::NumberOfArrays,
            }.with_indifferent_access
          end

          def unknown_calculator
            raise ::Exceptions::Pricing::UnknowCalculator
          end
        end
      end
    end
  end
end
