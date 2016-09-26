require_relative '../acceptance_helper'

feature 'Stuff replies to ticket', %q{
  In order to communicate with customer
  as a registered stuff
  I want to reply to ticket
} do

  context 'Authenticated stuff' do    
    let!(:stuff){ create :stuff } 
    let!(:tickets){ create_list :ticket, 2 } 
    let!(:closed_ticket){ create :ticket, status: 'completed' }   
           
    scenario 'waiting for stuff response status', js: true do    
      sign_in stuff
      expect(current_path).to eq opened_dashboard_path
      expect(page).to have_content tickets[0].random_id
      expect(page).to have_content tickets[1].random_id
      expect(page).to_not have_content closed_ticket.random_id

      within "#stuff_ticket_#{tickets[0].id}" do
        save_and_open_page
        fill_in 'Body', with: 'some body response'        
        click_on 'Submit'
        wait_for_ajax
        expect(page).to have_content 'some body response'
      end
      
    end 
  end
end