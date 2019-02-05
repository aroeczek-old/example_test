class CreateJoinTableCountryTargetGroup < ActiveRecord::Migration[5.2]
  def change
    create_table :countries_target_groups do |t|
      t.references :target_group, foreign_key: true, null: false
      t.references :country, foreign_key: true, null: false
      t.timestamps

      t.index [:target_group_id, :country_id], unique: true
    end
  end
end
