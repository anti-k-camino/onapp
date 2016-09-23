class DashboardController < ApplicationController
  def unassigned
    @tickets = Ticket.unassigned
  end
  def opened 
    @tickets = Ticket.opened
  end
  def onhold 
    @tickets = Ticket.onhold
  end
  def closed
    @ticket = Ticket.closed
  end
end
