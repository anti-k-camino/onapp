class ChangeTitleToStateStatuses < ActiveRecord::Migration
  def change
    remove_index :statuses, :title 
    remove_column :statuses, :title 
    add_column :statuses, :state, :string
    add_index :statuses, :state, unique: true
  end
end
