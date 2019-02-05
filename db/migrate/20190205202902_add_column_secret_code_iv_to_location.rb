class AddColumnSecretCodeIvToLocation < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :secret_code_iv, :string
    add_index :locations, :secret_code_iv, unique: true
  end
end
