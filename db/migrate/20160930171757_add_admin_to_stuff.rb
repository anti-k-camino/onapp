class AddAdminToStuff < ActiveRecord::Migration
  def change
    add_column :stuffs, :admin, :boolean, default: false
  end
end
