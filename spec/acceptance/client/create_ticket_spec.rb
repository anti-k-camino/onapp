require_relative '../acceptance_helper'

feature 'Guest should submit a query', %q{
  In order to alert an issure or ask smth
  as a guest user
  I want to submit a ticket query 
} do
  scenario 'guest user submits ticket query with valid attributes', js: true  do
    visit root_path
    fill_in 'Name', with: 'somename'
    fill_in 'Email', with: 'some@email.com'
    select 'dept1', from: "ticket[department]"
    fill_in 'Subject', with: 'bla-bla-bla'
    fill_in 'Body', with: 'somebody))'

    click_on 'Submit'
    wait_for_ajax
    open_email('some@email.com')
    expect(current_email).to have_content "ticket"
    expect(current_email).to have_content "your ticket id"
    expect(page).to have_content 'Ticket was successfully created.'    
    expect(current_path).to eq root_path
  end

   scenario 'guest user submits ticket query with invalid attributes', js: true  do
    visit root_path    
    fill_in 'Email', with: 'some@email.com'
    select 'dept2', from: "ticket[department]"
    fill_in 'Subject', with: 'bla-bla-bla'
    fill_in 'Body', with: 'somebody))'

    click_on 'Submit'
    wait_for_ajax
    expect(page).to have_content "Name can't be blank"
    expect(current_path).to eq root_path
  end
end