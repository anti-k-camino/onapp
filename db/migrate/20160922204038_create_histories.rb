class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.text :event
      t.integer :ticket_id

      t.timestamps null: false
    end
  end
end
