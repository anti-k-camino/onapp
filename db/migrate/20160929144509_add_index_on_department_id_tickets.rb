class AddIndexOnDepartmentIdTickets < ActiveRecord::Migration
  def change
    remove_column :tickets, :department 
    add_reference :tickets, :department, index: true
  end
end
