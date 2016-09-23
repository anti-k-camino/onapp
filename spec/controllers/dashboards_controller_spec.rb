require 'rails_helper'

RSpec.describe DashboardsController, type: :controller do
  describe 'GET#unassigned' do
    let!(:tickets){ create_list(:ticket, 2) }
    let!(:onhold_ticket){ create :ticket, status: 'on_hold'}
    
    it_behaves_like 'Authorizable'

    it_behaves_like 'Non Authorizable'

    def request
      return ['unassigned', get(:unassigned)]
    end
  end

  describe 'GET#opened' do
    let!(:tickets){ create_list(:ticket, 2) }
    let!(:opened_ticket){ create :ticket, status: 'canceled'}

    it_behaves_like 'Authorizable'

    it_behaves_like 'Non Authorizable'

    def request
      return ['opened', get(:opened)]
    end    
  end

  describe 'GET#onhold' do
    let!(:tickets){ create_list :ticket, 2, status: 'on_hold' }
    let!(:opened_ticket){ create :ticket, status: 'canceled'}
   
    it_behaves_like 'Authorizable'

    it_behaves_like 'Non Authorizable'

    def request
      return ['onhold', get(:onhold)]
    end
  end

  describe 'GET#onhold' do
    let!(:tickets){ create_list :ticket, 2, status: 'completed' }
    let!(:opened_ticket){ create :ticket, status: 'waiting_for_customer'}
   
    it_behaves_like 'Authorizable'

    it_behaves_like 'Non Authorizable'

    def request
      return ['closed', get(:closed)]
    end
  end

end
