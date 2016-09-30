require 'rails_helper'

RSpec.describe Status, type: :model do
  
  it { should validate_presence_of :state }
  it { should validate_uniqueness_of :state }
  it { should have_db_index :state }
  it { should have_many :tickets }
  
end
