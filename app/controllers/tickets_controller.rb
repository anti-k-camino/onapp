class TicketsController < ApplicationController
  before_action :authenticate_stuff!, only:[:stuff_update]  
  before_action :load_ticket, only:[:show, :update, :stuff_update]
  before_action :check_update_validness, only:[:update, :stuff_update]  
  before_action :set_waiting_stuff, only:[:update] 


  #before_action :set_waiting_customer, only:[:stuff_update]
  before_action :set_owner, only:[:stuff_update]

  after_action only:[:create, :update] do
    create_mail(:creation_email)
  end

  after_action only:[:stuff_update] do
    create_mail(:stuff_reply)
  end
    
  respond_to :js

  authorize_resource

  def create    
    respond_with @ticket = Ticket.create(ticket_params)
  end

  def update
    @ticket.update(ticket_params)
    respond_with @ticket 
  end

  def stuff_update
    @ticket.update(ticket_params)
    @ticket.reload     
    respond_with @ticket           
  end

  def show   
  end

  protected

  def check_update_validness
    current_stuff ? ( return if !@ticket.guest_update_avilable? ) : ( return if @ticket.guest_update_avilable? )    
    flash.now[:notice] = "Ticket status is #{@ticket.status.state}, please wait"
    #render "#{action_name}".to_sym and return  
    respond_with @ticket and return
  end

  def ticket_params
    params.require(:ticket).permit(:name, :subject, :email, :status_id, :body, :department_id, :stuff_id, replies_attributes: [:body])
  end

  def set_waiting_stuff
    @ticket.update(status: Status.waiting_for_stuff_response)    
  end

  def set_owner
    (@ticket.stuff_id = current_stuff.id if @ticket.stuff_id.blank?) unless params[:ticket][:stuff_id] 
  end  

  def set_waiting_customer          
    @ticket.update(status: Status.waiting_for_customer)     
  end

  def load_ticket
    @ticket = Ticket.find(params[:id])
  end

  def create_mail(param)        
    TicketMailer.send(param, @ticket).send(:deliver_later) unless @ticket.errors.any?
  end  
end
