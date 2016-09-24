class TicketsController < ApplicationController   
  before_action :load_ticket, only:[:show, :update]
  after_action :create_mail, only:[:create, :update]
  
  respond_to :js

  def create    
    respond_with @ticket = Ticket.create(ticket_params.merge(random_id: Ticket.generate_id))
  end

  def update
    flash[:notice] = "Your ticket successfully updated."    
    @ticket.update!(ticket_params)    
  end

  def show
  end

  protected
  def ticket_params
    params.require(:ticket).permit(:name, :subject, :email, :status, :body, :department, :stuff_id)
  end

  def load_ticket
    @ticket = Ticket.find(params[:id])
  end

  def create_mail        
    TicketMailer.creation_email(@ticket).deliver_now unless @ticket.errors.any?
  end
end
