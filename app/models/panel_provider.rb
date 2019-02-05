class PanelProvider < ApplicationRecord
  TYPES = %w(Panels::Panel_1 Panels::Panel_2 Panels::Panel_3).freeze

  has_one :target_group

  validates :type, inclusion: { in: TYPES }
end
