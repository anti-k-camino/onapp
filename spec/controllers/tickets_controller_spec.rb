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
    context 'valid_attributes' do
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

    context 'invalid attributes' do
      it 'should not trigger create_mail' do
        expect(TicketMailer).to_not receive(:creation_email).and_call_original
        post :create, ticket: { subject: 'subject', department: 1, body: 'body', email: 'some@we.com' }, format: :js     
      end

      it 'should not create a ticket' do
        expect{ post :create, ticket: { subject: 'subject', department: 1, body: 'body', email: 'some@we.com' }, format: :js }.to_not change(Ticket, :count)
      end   

      it 'should render view create' do
        post :create, ticket: attributes_for(:ticket), format: :js
        expect(response).to render_template :create
      end
    end
  end
  
  describe 'PATCH#update' do
    let!(:ticket){ create :ticket, status: 1 }
    let!(:stuff){ create :stuff }

    it 'should call create_mail' do
      expect(TicketMailer).to receive(:creation_email).and_call_original
      patch :update, id: ticket, ticket:{ body: 'Some new body'}, format: :js     
    end

    it "should set ticket's status to waiting for stuff response" do
      patch :update, id: ticket, ticket:{ body: 'Some new body'}, format: :js 
      expect(Ticket.last.current_status).to eq 'Waiting for stuff response' 
    end

    it 'should not create a new ticket' do
      expect{ patch :update, id: ticket, ticket:{ body: 'Some new body'}, format: :js }.to_not change(Ticket, :count)
    end

    it 'should not save a version of update', versioning: true do
      expect{ patch :update, id: ticket, ticket:{ body: 'Some new body'}, format: :js }.to change(ticket.versions, :count).by(1)
    end

    it 'should not save a version of update', versioning: true do
    end

=begin
    it 'should  not create a new history when status is not updated' do
      expect{ patch :update, id: ticket, ticket:{ status: 0 }, format: :js }.to_not change(ticket.histories, :count)     
    end

    it 'should create a new history when updating status' do
      expect{ patch :update, id: ticket, ticket:{ status: 2 }, format: :js }.to change(ticket.histories, :count).by(1)     
    end

    it 'should create a new history when updating status' do
      expect{ patch :update, id: ticket, ticket:{ stuff_id: stuff.id }, format: :js }.to change(ticket.histories, :count).by(1)     
    end

    it 'should not create a new history when updating others' do
      expect{ patch :update, id: ticket, ticket:{ body: 'Some new body'}, format: :js }.to_not change(ticket.histories, :count)
    end
=end
    it 'should render view update' do
      patch :update, id: ticket, ticket:{ body: 'Some new body'}, format: :js
      expect(response).to render_template :update
    end

  end 

end