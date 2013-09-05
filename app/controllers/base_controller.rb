require 'net/http'
require 'flare_config'

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
    resp = Net::HTTP.get_response(URI.parse("#{FlareConfig.lws_api_url}#{path}"))
    result = JSON.parse(resp.body)
  end
end