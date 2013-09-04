class CollectionsController < BaseController
  layout 'lw_flare'
  
  def index
    @collections = lws_api_get('/collections')
    
    @collections.each do |collection| 
      resp = find(blacklight_config.qt, {:q =>"*:*", :qt => ""}, collection["name"])
      collection["numFound"] = resp.response["numFound"]
    end
  end
  
  def find(*args)
    path = "#{args[2]}/#{blacklight_config.solr_path}"
    response = blacklight_solr.get(path, :params=> args[1])
    Blacklight::SolrResponse.new(force_to_utf8(response), args[1])
    rescue Errno::ECONNREFUSED => e
    raise Blacklight::Exceptions::ECONNREFUSED.new("Unable to connect to Solr instance using #{blacklight_solr.inspect}")
  end
  
  # Overriding blacklight_solr_config
  def blacklight_solr_config
    # Make the Solr URL dynamic based on the users session set collection, removes need/use of config/solr.yml
    # TODO: need to see how this will affect test runs
    # See also use of ENV['LWS_...'] in collection_manager_controller
    url ||= ENV['LWS_SOLR_URL']
    url ||= "#{ENV['LWS_CORE_URL']}/solr" if ENV['LWS_CORE_URL']
    {:url => "#{url || 'http://127.0.0.1:8888/solr/'}"}
  end
end