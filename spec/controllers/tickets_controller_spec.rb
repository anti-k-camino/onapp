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
      let!(:department){ create :department }

      it 'should call create_mail' do
        expect(TicketMailer).to receive(:creation_email).and_call_original
        post :create, ticket: attributes_for(:ticket, department_id: department.id ), format: :js     
      end

      it 'should create a ticket' do
        expect{ post :create, ticket: attributes_for(:ticket, department_id: department.id), format: :js }.to change(Ticket, :count).by(1)
      end

      it 'should create a ticket with right name' do
        post :create, ticket: attributes_for(:ticket, department_id: department.id), format: :js
        expect(Ticket.last.name).to eq 'somename'
      end

      it 'should create a ticket with right email' do
        post :create, ticket: attributes_for(:ticket, department_id: department.id), format: :js
        expect(Ticket.last.body).to eq 'somebody'
      end

      it 'should create a random id for a ticket' do        
        post :create, ticket: { name: 'namee', subject: 'subjecte', department_id: department.id, body: 'body', email: 'some@we.com' }, format: :js
        expect(Ticket.last.random_id.blank?).to be_falsy 
      end

      it 'should render view create' do
        post :create, ticket: attributes_for(:ticket, department_id: department.id), format: :js
        expect(response).to render_template :create
      end

    end

    context 'invalid attributes' do
      it 'should not trigger create_mail' do
        expect(TicketMailer).to_not receive(:creation_email).and_call_original
        post :create, ticket: { subject: 'subject', body: 'body', email: 'some@we.com' }, format: :js     
      end

      it 'should not create a ticket' do
        expect{ post :create, ticket: { subject: 'subject', department: 'dept1', body: 'body', email: 'some@we.com' }, format: :js }.to_not change(Ticket, :count)
      end   

      it 'should render view create' do
        post :create, ticket: attributes_for(:ticket), format: :js
        expect(response).to render_template :create
      end

    end

  end
=begin  
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

    it 'should render view update' do
      patch :update, id: ticket, ticket:{ body: 'Some new body'}, format: :js
      expect(response).to render_template :update
    end

  end 

  describe 'PATCH#stuff_update' do
    context 'Authenticated stuff' do
      let!(:ticket){ create :ticket }
      sign_in_stuff

      it 'should assign ticket to @ticket' do
        patch :stuff_update, id: ticket, ticket:{ replies_attributes: [body: 'Awesome response']}, format: :js
        expect(assigns :ticket).to eq ticket
      end

      it 'should not create a new ticket' do
        expect{ patch :stuff_update, id: ticket, ticket:{ replies_attributes: [body: 'Awesome response']}, format: :js }.to_not change(Ticket, :count)
      end

      it 'should create a new reply for ticket' do
        expect{ patch :stuff_update, id: ticket, ticket:{ replies_attributes: [body: 'Awesome response']}, format: :js }.to change(ticket.replies, :count).by(1)
      end
      context 'status' do
        it 'should set status to waiting for customer response if curr. status equals to waiting for stuff' do        
          patch :stuff_update, id: ticket, ticket:{ replies_attributes: [body: 'Awesome response'] }
          ticket.reload
          expect(ticket.current_status).to eq 'Waiting for customer'
        end

         it 'should not set status to waiting for customer response if status is set in params' do        
          patch :stuff_update, id: ticket, ticket:{ status: 'completed', replies_attributes: [body: 'Awesome response'] }        
          ticket.reload
          expect(ticket.current_status).to eq 'Completed'
        end
      end
      context 'owner' do
        let!(:another_stuff){ create :stuff }

        it 'should set owner to current stuff if params stuff is not mentioned' do
          patch :stuff_update, id: ticket, ticket:{ replies_attributes: [body: 'Awesome response'] }
          ticket.reload
          expect(ticket.stuff_id).to eq @stuff.id
        end

        it 'should set owner to stuff if params smentioned in params' do
          patch :stuff_update, id: ticket, ticket:{ stuff_id: another_stuff.id, replies_attributes: [body: 'Awesome response'] }
          ticket.reload
          expect(ticket.stuff_id).to eq another_stuff.id
        end
      end
    end

    context 'Non-authenticated stuff' do
      let!(:ticket){ create :ticket }

      it_behaves_like 'Non Authorizable'

      it 'should  not create a new reply for ticket' do
        expect{ patch :stuff_update, id: ticket, ticket:{ replies_attributes: [body: 'Awesome response']}, format: :js }.to_not change(ticket.replies, :count)
      end

      def request
        return [nil, patch(:stuff_update, id: ticket, ticket:{ replies_attributes: [body: 'Awesome response'] })]
      end
    end    
  end

=end
end