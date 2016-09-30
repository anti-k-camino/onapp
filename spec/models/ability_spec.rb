require 'rails_helper'

describe Ability  do
  subject(:ability){ Ability.new(stuff) }

  describe 'for guest' do
    let(:stuff){ nil }

    it { should be_able_to :create, Ticket }
    it { should be_able_to :show, Ticket }
    it { should be_able_to :update, Ticket }
    it { should_not be_able_to :manage, :all }
  end
=begin
  describe 'for admin' do
    let(:user){ create :user, admin: true }

    it { should be_able_to :manage, :all }
  end
=end
  describe 'for stuff' do

    let(:stuff){ create :stuff }
    let(:other_stuff){ create :stuff }
    let(:ticket){ create :ticket, stuff: stuff }
    let(:other_ticket){ create :ticket, stuff: other_stuff }
    let(:un_owned_ticket){ create :ticket }


    it { should_not be_able_to :manage, :all }    

    it { should be_able_to :stuff_update, ticket }
    it { should be_able_to :stuff_update, un_owned_ticket }
    it { should_not be_able_to :stuff_update, other_ticket }

  end   
end