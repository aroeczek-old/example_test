class AddColumnSecretCodeIvToTargetGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :target_groups, :secret_code_iv, :string
    add_index :target_groups, :secret_code_iv, unique: true
  end
end
