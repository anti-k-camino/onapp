class DashboardsController < ApplicationController
  before_action :authorize
  before_action :method

  def unassigned        
  end
  def opened     
  end
  def onhold     
  end
  def closed    
  end

  protected
  def method
    @tickets = Ticket.send(action_name.to_sym)
  end
end
