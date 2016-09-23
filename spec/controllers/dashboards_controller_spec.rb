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
=begin
  describe 'GET#' do
    let!(:tickets){ create_list(:ticket, 2) }
    let!(:opened_ticket){ create :ticket, status: 'canceled'}
    context 'authorized' do     
      sign_in_stuff
      before do
        get :opened
      end
      it 'should populate an array of unassigned tickets' do        
        expect( assigns :tickets ).to eq tickets
      end

      it 'should render template unassigned' do
        expect(response).to render_template 'opened'
      end
    end

    it_behaves_like 'Non Authorizable'

    def request
      get :opened
    end
  end
=end
end
