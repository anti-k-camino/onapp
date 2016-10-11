require_relative '../acceptance_helper'

feature 'Stuff replies to ticket', %q{
  In order to communicate with customer
  as a registered stuff
  I want to reply to ticket
} do

  context 'Authenticated stuff' do    
    let!(:stuff){ create :stuff } 
    let!(:status){ Status.create(state: 'closed') }
    let!(:tickets){ create_list :ticket, 2 } 
    let!(:closed_ticket){ create :ticket, status: status }   
           
    scenario 'waiting for stuff response status', js: true do    
      sign_in stuff
      expect(current_path).to eq workspace_dashboard_path
      visit opened_dashboard_path  
      expect(page).to have_content tickets[0].random_id
      expect(page).to have_content tickets[1].random_id
      expect(page).to_not have_content closed_ticket.random_id

      expect(page).to have_content "Ticket #{tickets[0].random_id} subject: #{tickets[0].subject}"

      click_on "Ticket #{tickets[0].random_id} subject: #{tickets[0].subject}"
      wait_for_ajax                      
      fill_in 'Body', with: 'some body response'        
        
      Sidekiq::Testing.inline! do
        click_on 'Submit'
        wait_for_ajax     
        current_email = ActionMailer::Base.deliveries.last
        expect(current_email).to have_content "Stuffs reply"        
      end

      #expect(page).to have_content ""
       
      
    end 
    
  end
end