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
end
