require 'net/http'

class CollectionManagerController < ApplicationController
  layout 'application'
  
  def index
    result = lws_api_get('/collections')
    # ==> [{"name":"collection1","instance_dir":"collection1_0"},{"name":"LucidWorksLogs","instance_dir":"LucidWorksLogs"}]
    
    @collections = result.collect {|c| c['name']}
  end
  
  def set
    session[:collection] = params[:collection]
    
    # Get roles
    result = lws_api_get("/collections/#{params[:collection]}/roles")
    
    # ==> [{"users":["admin"],"name":"DEFAULT","filters":["*:*"],"groups":[]},{"users":["bob"],"name":"restricted","filters":["-search"],"groups":[]}]
    # TODO: put this into application scope keyed by collection name?!  Or...??
    session[:collection_roles] = result
    
    redirect_to '/catalog'
  end  
  
  protected
  
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
