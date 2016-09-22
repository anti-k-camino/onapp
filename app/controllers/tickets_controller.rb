class TicketsController < ApplicationController
  respond_to :js
  after_action :send_create_mail, only:[:create]

  def create  
    @ticket = Ticket.create(ticket_params.merge(random_id: Ticket.generate_id))
    respond_with @ticket  
  end

  protected
  def ticket_params
    params.require(:ticket).permit(:name, :subject, :email, :status, :body, :department, :random_id)
  end
  def send_create_mail
  end
end
