require 'net/http'

class CollectionManagerController < ApplicationController
  layout 'application'
  
  def index
    # See also catalog_controller for use of ENV['LWS_...']
    url ||= ENV['LWS_API_URL']
    url ||= "#{ENV['LWS_CORE_URL']}/api" if ENV['LWS_CORE_URL']
    
    # http://localhost:8888/api/collections
    resp = Net::HTTP.get_response(URI.parse("#{url || 'http://127.0.0.1:8888/api'}/collections"))

    # ==> [{"name":"collection1","instance_dir":"collection1_0"},{"name":"LucidWorksLogs","instance_dir":"LucidWorksLogs"}]
    result = JSON.parse(resp.body)
    
    @collections = result.collect {|c| c['name']}
  end
  
  def set
    session[:collection] = params[:collection]
    redirect_to '/catalog'
  end  
end
