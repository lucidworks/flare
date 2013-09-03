# adapted from <https://github.com/psu-stewardship/archivesphere/blob/master/lib/devise/strategies/http_header_authenticatable.rb>

module Devise
  module Strategies
    class LwsAuthenticatable < ::Devise::Strategies::Base

      def valid?
        # Only a valid authentication request if there's a username
        params[:user][:username] ? true : false rescue false
      end

      # Very simple authentication, originally crafted only to check that the username specified exists
      # Note: There currently IS NO PASSWORD PROTECTION/CHECKING!
      #  TODO: to get password checking, would need to somehow need to encrypt the password the same as the lwe-ui app (impossible?!)
      #        or have the lws-ui app modified to allow for some kind of password check api
      def authenticate!
        # puts ">>>>>> authenticate!: #{params}"
        
        username = params[:user][:username]
        
        url ||= ENV['LWS_USER_API_BASE']  # defaults to http://127.0.0.1:8989
        resp = Net::HTTP.get_response(URI.parse("#{url || 'http://127.0.0.1:8989'}/api/users/#{username}"))
        
        # puts ">>>>>>>> /api/users/#{username} ==> #{resp.body}"
        
        # ==> {"username":"admin","email":"","authorization":"admin","encrypted_password":"$2a$10$eOu0r8WnUXc2V123QEYdzxuM6mXgTgPtf3L.ERjxiyxEFhobZJvRlW"}
        result = JSON.parse(resp.body)
        
        if result['username'] == username
          u = User.find_or_initialize_by_username(username)
          success!(u)
        else
          fail!
        end
        
      end
    end
  end
end

Warden::Strategies.add(:lws_authenticatable, Devise::Strategies::LwsAuthenticatable)