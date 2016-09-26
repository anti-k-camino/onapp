module AcceptenceHelpers
  def sign_in stuff
    visit login_path    
    fill_in 'Name', with: stuff.name    
    fill_in 'Password', with: stuff.password
    click_on 'Log in'
  end 
end
