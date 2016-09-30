require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_stuff
    @current_stuff ||= Stuff.find(session[:stuff_id]) if session[:stuff_id]
  end
  
  helper_method :current_stuff

  def authenticate_stuff!
    redirect_to login_path unless current_stuff
  end

  def current_ability
    @current_ability ||= Ability.new(current_stuff)
  end
end
