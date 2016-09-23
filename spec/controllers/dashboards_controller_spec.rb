require 'rails_helper'

RSpec.describe DashboardsController, type: :controller do
  describe 'GET#unassigned' do
    context 'authorized' do      
      let!(:tickets){ create_list(:ticket, 2) }
      let!(:onhold_ticket){ create :ticket, status: 'on_hold'}
      sign_in_stuff
      it 'should populate an array of unassigned tickets' do
        get :unassigned
        expect( assigns :tickets ).to eq tickets
      end
    end
  end

end
