module Pricing
  module PanelProviders
    module Price
      module CalculatorService
        def initialize(panel)
          @panel      = panel
          @calculator = calculator || select_calculator!
        end

        def self.call(panel:, calculator: nil)
          raise ArgumentError unless panel

          new(panel, calculator).call
        end

        def call
          calculator.call
        end

        private

        attr_reader :panel, :calculator

        def select_calculator!
          Pricing::PanelProviders::Price::Calculators::Factory.call(panel)
        end
      end
    end
  end
end
