require 'rails_helper'

RSpec.describe TicketsController, type: :controller do

  describe 'GET #show' do
    let!(:ticket){ create :ticket }
    before do
      get :show, id: ticket
    end
    it 'should assign ticket to @ticket' do      
      expect(assigns :ticket).to eq ticket
    end

    it 'should render view show' do      
      expect(response).to render_template :show
    end
  end

  describe 'POST #create' do
    it 'should call create_mail' do
      expect(TicketMailer).to receive(:creation_email).and_call_original
      post :create, ticket: attributes_for(:ticket), format: :js     
    end

    it 'should create a ticket' do
      expect{ post :create, ticket: attributes_for(:ticket), format: :js }.to change(Ticket, :count).by(1)
    end

    it 'should create a ticket with right name' do
      post :create, ticket: attributes_for(:ticket), format: :js
      expect(Ticket.last.name).to eq 'somename'
    end

    it 'should create a ticket with right email' do
      post :create, ticket: attributes_for(:ticket), format: :js
      expect(Ticket.last.body).to eq 'somebody'
    end

    it 'should create a random id for a ticket' do
      #expect{ post :create, ticket: { name: 'name', subject: 'subject', department: 1, body: 'body', email: 'some@we.com' }, format: :js }.to change(Ticket, :count).by(1)
      post :create, ticket: { name: 'name', subject: 'subject', department: 1, body: 'body', email: 'some@we.com' }, format: :js
      expect(Ticket.last.random_id.blank?).to be_falsy 
    end

    it 'should render view create' do
      post :create, ticket: attributes_for(:ticket), format: :js
      expect(response).to render_template :create
    end

  end

end
