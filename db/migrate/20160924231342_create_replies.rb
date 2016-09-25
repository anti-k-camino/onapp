class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.text :body
      t.integer :ticket_id, index: true
      t.timestamps null: false
    end
  end
end
