# Overrides to Blacklights facet handling
# to allow facets returned in the response to automatically render rather than having to be configured in the app via Blacklight configuration

module CatalogHelper
  include Blacklight::CatalogHelperBehavior
  
  # Pass in an RSolr::Response. Displays the "X Documents Found" message.
  def render_documents_info(response, options = {})
    total_num = response.response[:numFound]
    case total_num
      when 0; t('blacklight.search.documents.total.no_items_found', :total_num => total_num).html_safe
      when 1; t('blacklight.search.documents.total.one', :total_num => total_num).html_safe
      else; t('blacklight.search.documents.total.other', :total_num => total_num).html_safe
    end
  end
  
  
  def find2(*args)
     path = args[2]
    #path = blacklight_config.solr_path
     response = blacklight_solr.get(path, :params=> args[1])
     Blacklight::SolrResponse.new(force_to_utf8(response), args[1])
   rescue Errno::ECONNREFUSED => e
     raise Blacklight::Exceptions::ECONNREFUSED.new("Unable to connect to Solr instance using #{blacklight_solr.inspect}")
  end
  
end
