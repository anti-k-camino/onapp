class DashboardsController < ApplicationController
  before_action :authenticate_stuff!  
  before_action :method, except:[:workspace]

  

  def workspace
  end

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
    respond_with @tickets = Ticket.send(action_name.to_sym)
  end 
end
