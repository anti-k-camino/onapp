require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :subject }
  it { should validate_presence_of :random_id }
  it { should validate_presence_of :department }
  it { should validate_presence_of :status }
  #it { should have_many :histories }

  describe '.dept' do
    let!(:ticket){ create :ticket, department: 2 }

    it 'should return right dept' do
      expect(ticket.dept).to eq 'Dept3'
    end
  end

  describe '.current_status' do
    let!(:ticket){ create :ticket, status: 2 }

    it 'should return right dept' do
      expect(ticket.current_status).to eq 'On hold'
    end
  end

  describe '.opened' do
    let!(:ticket){ create :ticket, status: 'canceled' }
    let!(:ticket1){ create :ticket, status: 0 }
    let!(:ticket2){ create :ticket, status: 2 }
    let!(:ticket3){ create :ticket, status: 'completed' }
    let!(:ticket4){ create :ticket, status: 1 }

    it 'should not return canceled or completed' do 
      expect(Ticket.opened.include?(ticket)).to be_falsy
      expect(Ticket.opened.include?(ticket3)).to be_falsy 
    end

    it 'should return all except cancelled or completed' do
      expect(Ticket.opened).to eq [ticket1, ticket2, ticket4]      
    end
  end

  describe '.unassigned' do
    let!(:tickets){ create_list :ticket, 3 }

    before do
      tickets[1].update(status: 'completed')
    end

    it 'should return only unassigned tickets' do      
      expect(Ticket.unassigned).to eq [tickets[0], tickets[2]]
    end

    it 'should not return other statuses' do
      expect(Ticket.unassigned.include?(tickets[1])).to be_falsy
    end
  end
=begin
  describe 'status_owner_changed?' do
    let!(:ticket){ create :ticket }
    let!(:stuff){ create :stuff }

    it 'should return true if status changed' do
      ticket.status = 3
      expect(ticket.status_owner_changed?).to be_truthy
    end

    it 'should return true if owner changed' do
      ticket.stuff = stuff
      expect(ticket.status_owner_changed?).to be_truthy
    end

    it 'should return false in case of other updates' do
      ticket.subject = 'New subject'
      expect(ticket.status_owner_changed?).to be_falsy
    end
  end
=end
  describe '.onhold' do
    let!(:tickets){ create_list :ticket, 3 }

    before do
      tickets[1].update(status: 'on_hold')
    end

    it 'should return only on_hold tickets' do      
      expect(Ticket.onhold).to eq [tickets[1]]
    end

    it 'should not return other statuses' do
      expect(Ticket.onhold.include?(tickets[0])).to be_falsy
    end
  end

  describe '.onhold' do
    let!(:tickets){ create_list :ticket, 3 }

    before do
      tickets[1].update(status: 'on_hold')
    end

    it 'should return only on_hold tickets' do      
      expect(Ticket.onhold).to eq [tickets[1]]
    end

    it 'should not return other statuses' do
      expect(Ticket.onhold.include?(tickets[0])).to be_falsy
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
  describe '.closed' do
    let!(:ticket){ create :ticket, status: 'canceled' }
    let!(:ticket1){ create :ticket, status: 0 }
    let!(:ticket2){ create :ticket, status: 2 }
    let!(:ticket3){ create :ticket, status: 'completed' }
    let!(:ticket4){ create :ticket, status: 1 }

    it 'should not return canceled or completed' do 
      expect(Ticket.closed.include?(ticket1)).to be_falsy
      expect(Ticket.closed.include?(ticket2)).to be_falsy 
    end

    it 'should return all except cancelled or completed' do
      expect(Ticket.closed).to eq [ticket, ticket3]      
    end
   
  end


end
