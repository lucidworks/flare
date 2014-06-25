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
    options = {headers: solr_headers}
    resp = HTTParty.get("#{FlareConfig.lws_api_url}#{path}", options)
    result = JSON.parse(resp.body)
  end
  
  def solr_headers
    if request.headers["HTTP_LWS_ROLES"].blank? || request.headers["HTTP_AUTHORIZATION"].blank?
      {}
    else
      {"lws_roles" => request.headers["HTTP_LWS_ROLES"], "Authorization" => request.headers["HTTP_AUTHORIZATION"]}
    end
  end
end