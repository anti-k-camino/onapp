require_relative '../acceptance_helper'

feature 'Guest should submit a query', %q{
  In order to alert an issure or ask smth
  as a guest user
  I want to submit a ticket query 
} do
  let!(:department1){ create :department, title: 'dept1'}
  let!(:department2){ create :department, title: 'dept2'}
  let!(:status){ create :status, state: 'waiting for stuff response'}
  scenario 'guest user submits ticket query with valid attributes', js: true  do    
    visit root_path
    fill_in 'Name', with: 'somename'
    fill_in 'Email', with: 'some@email.com'
    select 'dept1', from: "ticket[department_id]"
    fill_in 'Subject', with: 'bla-bla-bla'
    fill_in 'Body', with: 'somebody))'

    click_on 'Submit'
    wait_for_ajax
=begin
    open_email('some@email.com')    
    expect(current_email).to have_content "ticket"
    expect(current_email).to have_content "your ticket id"
=end
    
    expect(page).to have_content 'Ticket was successfully created.'    
    expect(current_path).to eq root_path
  end

   scenario 'guest user submits ticket query with invalid attributes', js: true  do
    visit root_path    
    fill_in 'Email', with: 'some@email.com'
    select 'dept2', from: "ticket[department_id]"
    fill_in 'Subject', with: 'bla-bla-bla'
    fill_in 'Body', with: 'somebody))'

    click_on 'Submit'
    wait_for_ajax
    expect(page).to have_content "Name can't be blank"
    expect(current_path).to eq root_path
  end
end