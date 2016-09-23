class AddIndexToStuffsName < ActiveRecord::Migration
  def change
    add_index :stuffs, :name, unique: true
  end
end
