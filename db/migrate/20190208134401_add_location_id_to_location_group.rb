class AddLocationIdToLocationGroup < ActiveRecord::Migration[5.2]
  def change
    add_reference :location_groups, :location, index: true, null: false
  end
end
