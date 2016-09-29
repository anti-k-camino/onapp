class AddDepartmentIdToTickets < ActiveRecord::Migration
  def change
    remove_column :tickets, :department 
    add_column :tickets, :department, :integer
  end
end
