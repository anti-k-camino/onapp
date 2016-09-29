require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :subject }
  it { should validate_presence_of :random_id }
  it { should validate_presence_of :department_id }
  it { should validate_presence_of :status }
  it { should have_many :replies }
  it { should belong_to :department}
  it { should accept_nested_attributes_for :replies }


  describe '.current_status' do    
    let!(:ticket){ create :ticket, status: 'on_hold' }

    it 'should return right dept' do
      expect(ticket.current_status).to eq 'On hold'
    end
  end

  describe 'Stauses class methods' do    
    let!(:ticket){ create :ticket, status: 'canceled' }
    let!(:ticket1){ create :ticket, status: 'waiting_for_stuff_response' }
    let!(:ticket2){ create :ticket, status: 'on_hold' }
    let!(:ticket3){ create :ticket, status: 'completed' }
    let!(:ticket4){ create :ticket, status: 'waiting_for_customer' }
    
    describe '.opened' do      
      it_should_behave_like "Method" 

      def res
        return{ method: :opened, result: [ticket1, ticket2, ticket4], invalid: ticket }
      end                
    end

    describe '.unassigned' do
      it_should_behave_like "Method" 

      def res
        return{ method: :unassigned, result: [ticket1], invalid: ticket3 }
      end                
    end

    describe '.onhold' do
      it_should_behave_like "Method" 

      def res
        return{ method: :onhold, result: [ticket2], invalid: ticket1 }
      end                
    end

    describe '.closed' do
      it_should_behave_like "Method" 

      def res
        return{ method: :closed, result: [ticket, ticket3], invalid: ticket1 }
      end                
    end
    
  end
end
=begin
  describe "`have_a_version_with` matcher" do
    let!(:ticket){ create :ticket } 

    it "is possible to do assertions on versions", versioning: true do
      ticket.update(status: 'completed')
      ticket.reload
      expect(ticket).to have_a_version_with status: 'completed'       
    end
  end
=end