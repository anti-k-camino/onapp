class TicketMailer < ApplicationMailer
  default from: 'tickets@example.com'
 
  def creation_email(ticket)
    @ticket = ticket    
    @url  = "http://localhost:3000/tickets/#{@ticket.id}"
    mail(to: @ticket.email, subject: 'Your ticket has been created')
  end
  
end