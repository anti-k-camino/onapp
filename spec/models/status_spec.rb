require 'rails_helper'

RSpec.describe Status, type: :model do
  
  it { should validate_presence_of :state }
  it { should validate_uniqueness_of :state }
  it { should have_db_index :state }
  it { should have_many :tickets }

  describe 'State assign methods' do

    let!(:status){ create :status, state: 'canceled'}
    let!(:status1){ create :status, state: 'waiting for stuff response'} 
    let!(:status2){ create :status, state: 'on hold'} 
    let!(:status3){ create :status, state: 'closed'} 
    let!(:status4){ create :status, state: 'waiting for customer'}

    describe '.canceled' do
      it_should_behave_like "SelfAssignable"
      def res
        { method: :canceled, result: status }
      end
    end

    describe '.waiting for stuff response' do

      it_should_behave_like "SelfAssignable"

      def res
        { method: :waiting_for_stuff_response, result: status1 }
      end
    end

    describe '.on hold' do

      it_should_behave_like "SelfAssignable"

      def res
        { method: :on_hold, result: status2 }
      end
    end

    describe '.closed' do

      it_should_behave_like "SelfAssignable"

      def res
        { method: :closed, result: status3 }
      end
    end

    describe '.waiting for customer' do

      it_should_behave_like "SelfAssignable"

      def res
        { method: :waiting_for_customer, result: status4 }
      end
    end
    

  end
  
end
