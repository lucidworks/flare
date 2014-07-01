require 'net/http'
require 'flare_config'

class BaseController < ApplicationController
  abstract!
  
  include Blacklight::Catalog
  include BaseHelper
  
  helper_method :current_collection

  def current_collection
    @current_collection = lws_api_get("/collections/#{params[:collection_id]}") || {}
    @current_collection.merge :roles => lws_api_get("/collections/#{params[:collection_id]}/roles")
  end
  
  private
  
  # TODO: refactor to use lucidworks-ruby gem
  def lws_api_get(path)
    options = {headers: solr_headers}
    response = HTTParty.get("#{FlareConfig.lws_api_url}#{path}", options)
    Rails.logger.info("RESPONSE CODE: #{response.code}")
    if response.code == 200
      result = JSON.parse(response.body)
    else
      nil
    end
  end
  
  def solr_headers
    headers = 
    if request.headers["HTTP_LWS_ROLES"].blank? || request.headers["HTTP_AUTHORIZATION"].blank?
      {}
    else
      {"lws_roles" => request.headers["HTTP_LWS_ROLES"], "Authorization" => request.headers["HTTP_AUTHORIZATION"]}
    end
    headers
  end
end