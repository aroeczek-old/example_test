class CreateLocationGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :location_groups do |t|
      t.string     :name, null: false
      t.references :country, foreign_key: true, index: true
      t.references :panel_provider, foreign_key: true, index: true

      t.timestamps
    end
  end
end
