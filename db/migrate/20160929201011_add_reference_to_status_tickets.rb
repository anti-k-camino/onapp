class AddReferenceToStatusTickets < ActiveRecord::Migration
  def change
    remove_index :tickets, :status 
    remove_column :tickets, :status 
    add_reference :tickets, :status 
    add_index :tickets, :status_id
  end
end
