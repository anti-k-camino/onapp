require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :subject }
  it { should validate_presence_of :random_id }
  it { should validate_presence_of :department }
  it { should validate_presence_of :status }
  it { should have_many :histories }

  describe '.dept' do
    let!(:ticket){ create :ticket, department: 2 }

    it 'should return right dept' do
      expect(ticket.dept).to eq 'Dept3'
    end
  end

  describe '.status' do
    let!(:ticket){ create :ticket, status: 2 }

    it 'should return right dept' do
      expect(ticket.current_status).to eq 'On hold'
    end
  end
end
