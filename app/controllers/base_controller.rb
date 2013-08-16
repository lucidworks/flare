require 'net/http'

class BaseController < ApplicationController
  abstract!
  
  include BaseHelper

  helper_method :current_collection
  helper_method :current_collection_roles

  def current_collection
    collection_id = params[:collection_id]  
    @current_collection = lws_api_get("/collections/#{collection_id}")
  end
  
  def current_collection_roles
    collection_id = params[:collection_id] 
    @roles = lws_api_get("/collections/#{collection_id}/roles")
  end
  
  def build_collections
    result = lws_api_get('/collections')
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
