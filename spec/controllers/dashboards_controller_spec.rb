require 'rails_helper'

RSpec.describe DashboardsController, type: :controller do

  describe 'GET#unassigned' do   
    let!(:stuff){ create :stuff }
    let!(:tickets){ create_list :ticket, 2, stuff: stuff }
    let!(:unassigned){ create :ticket }
    
    sign_in_stuff

    it 'should populate array of unassigned tickets' do                 
      get :unassigned
      expect(assigns(:tickets)).to match_array([unassigned])
    end
  end
=begin
  describe 'GET#opened' do
    let!(:tickets){ create_list :ticket, 2, status: Status.waiting_for_stuff_response }
    let!(:opened_ticket){ create :ticket, status: Status.canceled }

    it_behaves_like 'Authorizable'

    it_behaves_like 'Non Authorizable'

    def request
      return ['opened', get(:opened)]
    end    
  end

  describe 'GET#onhold' do
    let!(:tickets){ create_list :ticket, 2, status: Status.on_hold }
    let!(:opened_ticket){ create :ticket, status: Status.canceled}
   
    it_behaves_like 'Authorizable'

    it_behaves_like 'Non Authorizable'

    def request
      return ['onhold', get(:on_hold)]
    end
  end

  describe 'GET#closed' do
    let!(:tickets){ create_list :ticket, 2, status: Status.closed }
    let!(:opened_ticket){ create :ticket, status: Status.waiting_for_customer}
   
    it_behaves_like 'Authorizable'

    it_behaves_like 'Non Authorizable'

    def request
      return ['closed', get(:closed)]
    end
  end
=end
end
