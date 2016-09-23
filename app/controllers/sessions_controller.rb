class SessionsController < ApplicationController
  def create
    stuff = Stuff.find_by_name(params[:name])
    # If the user exists AND the password entered is correct.
    if stuff && stuff.authenticate(params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user 
      # logged in when they navigate around our website.
      session[:stuff_id] = stuff.id
      redirect_to '/'
    else
    # If user's login doesn't work, send them back to the login form.
      redirect_to '/login'
    end
  end

  def destroy
    session[:stuff_id] = nil
    redirect_to '/login'
  end

end