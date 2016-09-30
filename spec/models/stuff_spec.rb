require 'rails_helper'

RSpec.describe Stuff, type: :model do
  it{ should have_many :tickets }
  it{ should validate_presence_of :name }
  it{ should validate_uniqueness_of :name }
  it{ should have_many :tickets }

  describe '.owner_of?' do
    let!(:stuff){ create :stuff }
    let!(:ticket){ create :ticket, stuff: stuff }
    let!(:not_owned_ticket){ create :ticket }

    it 'should return true if owner' do
      expect(stuff.owner_of? ticket).to be_truthy
    end
    
    it 'should return false if not an owner' do
      expect(stuff.owner_of? not_owned_ticket).to be_falsy
    end
  end
end
