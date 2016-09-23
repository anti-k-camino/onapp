class SessionsController < ApplicationController
  before_action :set_stuff, only:[:create]
  def create    
    if @stuff && @stuff.authenticate(params[:password])      
      session[:stuff_id] = @stuff.id
      redirect_to '/'
    else    
      redirect_to '/login'
    end
  end

  def destroy
    session[:stuff_id] = nil
    redirect_to '/login'
  end

  private
  def set_stuff
    @stuff = Stuff.find_by_name(params[:name])
  end
end