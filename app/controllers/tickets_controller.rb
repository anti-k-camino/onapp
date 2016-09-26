class TicketsController < ApplicationController
  before_action :authorize, only:[:stuff_update]  
  before_action :load_ticket, only:[:show, :update, :stuff_update, :edit]
  before_action :set_waiting_customer, only:[:stuff_update]

  after_action only:[:create, :update] do
    create_mail(:creation_email)
  end

  after_action only:[:stuff_update] do
    create_mail(:stuff_reply)
  end


  
  respond_to :js

  def create    
    respond_with @ticket = Ticket.create(ticket_params.merge(random_id: Ticket.generate_id))
  end

  def update        
    @ticket.update(ticket_params.merge(status: 0))
    flash[:notice] = 'Your ticket successfully updated.'  
  end

  def stuff_update                
    @ticket.update(ticket_params) 
    respond_with @ticket           
  end

  def show
  end

  protected
  def ticket_params
    params.require(:ticket).permit(:name, :subject, :email, :status, :body, :department, :stuff_id, replies_attributes: [:body])
  end

  def set_waiting_customer
    params[:ticket][:status] = 'waiting_for_customer' if ticket_params[:status] == 'waiting_for_stuff_response'
  end

  def load_ticket
    @ticket = Ticket.find(params[:id])
  end

  def create_mail(param)        
    TicketMailer.send(param, @ticket).send(:deliver_now) unless @ticket.errors.any?
  end  
end
