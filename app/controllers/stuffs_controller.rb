class StuffsController< ApplicationController
  def new
  end

  def create
    @stuff = Stuff.new(stuff_params)
    if @stuff.save
      session[:stuff_id] = @stuff.id
      redirect_to workspace_dashboard_path
    else
      redirect_to '/signup'
    end
  end
  
  private
  def stuff_params
    params.require(:stuff).permit(:name, :password, :password_confirmation)
  end
end
