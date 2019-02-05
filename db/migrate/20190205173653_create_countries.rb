class CreateCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :countries do |t|
      t.string     :code
      t.references :panel_provider, foreign_key: true, index: true

      t.timestamps
    end
  end
end
