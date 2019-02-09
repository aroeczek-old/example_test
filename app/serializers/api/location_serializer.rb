module Api
  class LocationSerializer < Api::BaseSerializer
    attributes :id, :name, :external_id, :parent_id, :panel_provider_id, :created_at
  end
end
