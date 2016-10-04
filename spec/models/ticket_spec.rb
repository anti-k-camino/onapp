require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :subject }  
  it { should validate_presence_of :department_id }
  it { should validate_presence_of :status_id }
  it { should have_many :replies }
  it { should belong_to :department}
  it { should accept_nested_attributes_for :replies }

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

    describe '.unassigned' do
      let!(:stuff){ create :stuff }
      let!(:tickets){ create_list :ticket, 2, stuff: stuff }
      let!(:unassigned){ create :ticket }
      
      it 'should return an array of unasigned tickets' do
        expect(Ticket.unassigned).to_not eq tickets
      end

      it 'should not return owned tickets' do
        expect(Ticket.unassigned.include? unassigned).to be_truthy
      end 
               
    end
    
    describe '.opened' do      
      it_should_behave_like "Method"       

      def res
        { method: :opened, result: [ticket1, ticket2, ticket4], invalid: ticket }
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

  describe '#guest_update_avilable?' do

    let!(:status){ create :status, state: 'waiting for customer' }
    let!(:unavailable_status1){ create :status, state: 'waiting for stuff response' }
    let!(:unavailable_status2){ create :status, state: 'on hold' }
    let!(:ticket){ create :ticket, status: status }
    let!(:unavailable_ticket1){ create :ticket, status: unavailable_status1 }
    let!(:unavailable_ticket2){ create :ticket, status: unavailable_status2 }
    
    it 'should retun true if status is waiting for customer' do
      expect(ticket.guest_update_avilable?).to be_truthy
    end

    it 'should retun true if status is waiting for customer' do
      expect(unavailable_ticket1.guest_update_avilable?).to be_falsy
    end

    it 'should retun true if status is waiting for customer' do
      expect(unavailable_ticket2.guest_update_avilable?).to be_falsy
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
