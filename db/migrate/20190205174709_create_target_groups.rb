class CreateTargetGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :target_groups do |t|
      t.string     :name, null: false
      t.uuid       :external_id
      t.references :parent, foreign_key: { to_table: :target_groups }, null: true
      t.string     :secret_code
      t.references :panel_provider, foreign_key: true, index: true

      t.timestamps
    end
  end
end
