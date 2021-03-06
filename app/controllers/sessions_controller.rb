class SessionsController < ApplicationController  
  before_action :authenticate_stuff!, only:[:destroy]
  before_action :set_stuff, only:[:create] 
  
  def create    
    if @stuff && @stuff.authenticate(params[:password])      
      session[:stuff_id] = @stuff.id
      flash[:notice] = "Successfully signed in."
      redirect_to workspace_dashboard_path
    else
      flash[:alert] = "Invalid login or password."
      redirect_to login_path      
    end
  end

  def destroy
    session[:stuff_id] = nil
    redirect_to login_path
  end

  private
  def set_stuff
    @stuff = Stuff.find_by_name(params[:name])
  end
end