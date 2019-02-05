class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :name, null: false
      t.uuid   :external_id
      t.string :secret_code

      t.timestamps
    end
  end
end
