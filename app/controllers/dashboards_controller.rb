class DashboardsController < ApplicationController
  before_action :authenticate_stuff!  
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
    respond_with @tickets = Ticket.send(action_name.to_sym).includes(:replies)
  end 
end
