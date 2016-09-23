module ControllerMacros
  def sign_in_stuff
    before do
      @stuff = create(:stuff)
      @stuff.authenticate(@stuff.password)
      session[:stuff_id] = @stuff.id
    end
  end 
end