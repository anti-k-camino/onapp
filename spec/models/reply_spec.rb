require 'rails_helper'

RSpec.describe Reply, type: :model do
  it{ should belong_to :ticket }
  it{ should have_db_index :ticket_id }
end
