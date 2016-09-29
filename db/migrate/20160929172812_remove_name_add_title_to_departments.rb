class RemoveNameAddTitleToDepartments < ActiveRecord::Migration
  def change
    remove_index :departments, :name 
    remove_column :departments, :name
    add_column :departments, :title, :string
    add_index :departments, :title, unique: true
  end
end
