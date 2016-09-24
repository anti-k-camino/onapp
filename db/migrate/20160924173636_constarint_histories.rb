class ConstarintHistories < ActiveRecord::Migration
  def change
    remove_column :histories, :event
    add_column :histories, :event, :text, default: "", null: false
  end
end
