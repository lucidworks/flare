class ApplicationController < ActionController::Base
  # Adds a few additional behaviors into the application controller 
   include Blacklight::Controller
   
  # Please be sure to impelement current_user and user_session. Blacklight depends on 
  # these methods in order to perform user specific actions. 

  layout 'blacklight'

  protect_from_forgery
  
  # Devise hooks to redirect user after log in/out
  def after_sign_in_path_for(resource)
    session[:collection] ? catalog_path(:index) : root_path
  end
  
  def after_sign_out_path_for(resource)
    catalog_path(:index) # this will redirect to collection selector if necessary
  end
  
end
