class AddIndexesOnTickets < ActiveRecord::Migration
  def change
    add_index :tickets, :status
    add_index :tickets, :email
    add_index :tickets, :random_id
  end
end
