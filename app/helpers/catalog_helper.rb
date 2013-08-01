# Overrides to Blacklights facet handling
#   - to allow facets returned in the response to automatically render rather than having to be configured in the app via Blacklight configuration

module CatalogHelper
  include Blacklight::CatalogHelperBehavior
  
#This should find the landing page value from solr, and if present return true  
  def has_landing_page?()
    return false
  end
  
end
