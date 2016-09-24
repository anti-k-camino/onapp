class AddStatusAndOwnerToHistories < ActiveRecord::Migration
  def change
    add_column :histories, :ticket_owner, :string, default: ""
    add_column :histories, :ticket_status, :string, default: ""
  end
end
