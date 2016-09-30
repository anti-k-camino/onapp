require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :subject }
  it { should validate_presence_of :random_id }
  it { should validate_presence_of :department_id }
  it { should validate_presence_of :status_id }
  it { should have_many :replies }
  it { should belong_to :department}
  it { should accept_nested_attributes_for :replies }

=begin
  describe '.current_status' do    
    let!(:ticket){ create :ticket, status: 'on_hold' }

    it 'should return right dept' do
      expect(ticket.current_status).to eq 'On hold'
    end
  end
=end
  describe 'Ticket statuses query methods' do 
    let!(:status){ create :status, state: 'canceled'}
    let!(:status1){ create :status, state: 'waiting for stuff response'} 
    let!(:status2){ create :status, state: 'on hold'} 
    let!(:status3){ create :status, state: 'closed'} 
    let!(:status4){ create :status, state: 'waiting for customer'}  

    let!(:ticket){ create :ticket, status: status }
    let!(:ticket1){ create :ticket, status: status1 }
    let!(:ticket2){ create :ticket, status: status2 }
    let!(:ticket3){ create :ticket, status: status3 }
    let!(:ticket4){ create :ticket, status: status4 }
    
    describe '.opened' do      
      it_should_behave_like "Method" 
      p "OOO"
      p Ticket.count

      def res
        { method: :opened, result: [ticket1, ticket2, ticket4], invalid: ticket }
      end                
    end

    describe '.unassigned' do
      it_should_behave_like "Method" 

      def res
        { method: :unassigned, result: [ticket1], invalid: ticket3 }
      end                
    end

    describe '.onhold' do
      it_should_behave_like "Method" 

      def res
        { method: :onhold, result: [ticket2], invalid: ticket1 }
      end                
    end

    describe '.closed' do
      it_should_behave_like "Method" 

      def res
        { method: :closed, result: [ticket, ticket3], invalid: ticket1 }
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

describe 'creation' do
  it 'should assign status waiting for stuff response to freshly created ticket' do
    expect(Ticket).to receive :
  end
end
=end
