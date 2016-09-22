require 'rails_helper'

RSpec.describe History, type: :model do
  it { should belong_to :ticket }
  it { should have_db_index :ticket_id }
end
