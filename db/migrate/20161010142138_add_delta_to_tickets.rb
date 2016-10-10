class AddDeltaToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :delta, :boolean, default: true, null: false
  end
end
