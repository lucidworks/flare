class User < ActiveRecord::Base
# Connects this user object to Blacklights Bookmarks. 
 include Blacklight::User

 Devise.add_module(:lws_authenticatable,
                   :strategy => true,
                   :route => :session,
                   :controller => :sessions,
                   :model => 'devise/models/lws_authenticatable') 
                    
 devise :lws_authenticatable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username

  # Method added by Blacklight; Blacklight uses #to_s on your
  # user class to get a user-displayable login/identifier for
  # the account. 
  def to_s
    username
  end
end
