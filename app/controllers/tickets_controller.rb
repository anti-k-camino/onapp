class TicketsController < ApplicationController
  #before_action :authorize, only:[:stuff_update]  
  before_action :load_ticket, only:[:show, :update, :stuff_update, :edit]
  after_action :create_mail, only:[:create, :update]  
  
  respond_to :js

  def create    
    respond_with @ticket = Ticket.create(ticket_params.merge(random_id: Ticket.generate_id))
  end

  def update        
    @ticket.update(ticket_params.merge(status: 0))
    flash[:notice] = 'Your ticket successfully updated.'  
  end

  def stuff_update   
    p 'OOOOOOOOOOOOOOOOOOOOO'
    params[:ticket][:status] = 'waiting_for_customer' if ticket_params[:status] == 'waiting_for_stuff_response'
    
    p ticket_params[:status]         
    @ticket.update(ticket_params) 
    flash[:notice] = 'Ticket has been updated.'       
  end

  def show
  end

  protected
  def ticket_params
    params.require(:ticket).permit(:name, :subject, :email, :status, :body, :department, :stuff_id, replies_attributes: [:id, :body])
  end

  def load_ticket
    @ticket = Ticket.find(params[:id])
  end

  def create_mail        
    TicketMailer.creation_email(@ticket).deliver_now unless @ticket.errors.any?
  end
end
