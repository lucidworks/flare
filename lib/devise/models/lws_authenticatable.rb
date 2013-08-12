require 'devise/strategies/lws_authenticatable'
module Devise
  module Models
    module LwsAuthenticatable
      extend ActiveSupport::Concern

      # TODO: Why is this overridden?  This is how examples I cribbed from were crafted, so I kept it
      def after_database_authentication
      end

    protected


    end
  end
end