require 'net/http'

class BaseController < ApplicationController
  abstract!
  
  include Blacklight::Catalog
  include BaseHelper
  
  helper_method :current_collection

  def current_collection
    @current_collection = lws_api_get("/collections/#{params[:collection_id]}")
    @current_collection.merge :roles => lws_api_get("/collections/#{params[:collection_id]}/roles")
  end
  
  private
  
  # TODO: refactor to use lucidworks-ruby gem
  def lws_api_get(path)
    # See also catalog_controller for use of ENV['LWS_...']
    url ||= ENV['LWS_API_URL']
    url ||= "#{ENV['LWS_CORE_URL']}/api" if ENV['LWS_CORE_URL']
    
    # http://localhost:8888/api/collections
    resp = Net::HTTP.get_response(URI.parse("#{url || 'http://127.0.0.1:8888/api'}#{path}"))
    result = JSON.parse(resp.body)
  end
end