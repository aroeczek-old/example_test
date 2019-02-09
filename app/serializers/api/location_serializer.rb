module Api
  class LocationSerializer < Api::BaseSerializer
    attributes :id, :name, :external_id, :created_at
  end
end
