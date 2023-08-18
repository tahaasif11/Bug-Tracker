class RenameColumnInTableName < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :typee, :user_type
    rename_column :bugs, :typee, :bug_type
  end
end
