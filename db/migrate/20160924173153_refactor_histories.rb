class RefactorHistories < ActiveRecord::Migration
  def change
    remove_column :histories, :ticket_owner
    remove_column :histories, :ticket_status
    remove_column :histories, :event
    add_column :histories, :event, :text
  end
end
