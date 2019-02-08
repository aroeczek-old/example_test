class PanelProvider < ApplicationRecord
  TYPES = %w(Panels::Panel_1 Panels::Panel_2 Panels::Panel_3).freeze

  has_one :target_group

  validates :type, inclusion: { in: TYPES }
  validates :code, presence: true, uniqueness: true

  def price
    Pricing::PanelProviders::Price::CalculatorService.call(self)
  end
end
