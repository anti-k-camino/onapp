class AddIndexOnTicketIdToHistories < ActiveRecord::Migration
  def change
    add_index :histories, :ticket_id
  end
end
