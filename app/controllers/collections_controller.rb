require 'flare_config'

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
    {:url => "#{FlareConfig.solr_url}/" } # trailing slash needed?  
  end
end