require 'rails_helper'

RSpec.describe Department, type: :model do
  it { should validate_presence_of :title }
  it { should validate_uniqueness_of :title }
  it { should have_db_index :title }
end
