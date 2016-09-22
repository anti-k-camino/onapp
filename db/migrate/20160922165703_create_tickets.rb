class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string   "name",       default: "", null: false
      t.string   "email",      default: "", null: false
      t.string   "subject",    default: "", null: false
      t.text     "body",       default: "", null: false
      t.datetime "created_at",              null: false
      t.datetime "updated_at",              null: false
      t.string   "random_id",               null: false
      t.integer  "stuff_id"
      t.integer  "department",              null: false
      t.integer  "status",     default: 0,  null: false
      t.timestamps null: false
    end
  end
end

