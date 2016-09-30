class AddIndexToStatusName < ActiveRecord::Migration
  def change
    add_index :statuses, :name
  end
end
