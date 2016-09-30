class ChangeNameToTitleStatus < ActiveRecord::Migration
  def change
    remove_index :statuses, :name 
    remove_column :statuses, :name 
    add_column :statuses, :title, :string
    add_index :statuses, :title, unique: true
  end
end
