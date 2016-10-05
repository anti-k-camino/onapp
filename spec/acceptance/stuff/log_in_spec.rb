require_relative '../acceptance_helper'

feature 'Stuff can sign in', %q{
  In order to gain stuff ability
  as a registered stuff
  I want to sign in
} do
  context 'Registered stuff' do
    let!(:stuff){ create :stuff , password: '123123'}
    scenario 'With valid attributes' do      
      visit root_path
      click_on 'Login'
      expect(current_path).to eq login_path
      fill_in 'Name', with: stuff.name 
      fill_in 'Password', with: '123123'
      click_on 'Log in'
      expect(current_path).to eq opened_dashboard_path
      expect(page).to have_content 'Successfully signed in.'
    end

    scenario 'Non valid attributes' do
      visit root_path
      click_on 'Login'
      expect(current_path).to eq login_path
      fill_in 'Name', with: stuff.name 
      fill_in 'Password', with: '123124'
      click_on 'Log in'
      expect(current_path).to eq login_path
      expect(page).to have_content 'Invalid login or password'
    end
  end
end