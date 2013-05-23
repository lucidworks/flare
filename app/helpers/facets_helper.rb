# Overrides to Blacklights facet handling
#   - to allow facets returned in the response to automatically render rather than having to be configured in the app via Blacklight configuration

module FacetsHelper
  include Blacklight::FacetsHelperBehavior
  
  def facet_field_names
    @response.facet_counts["facet_fields"].keys
  end
  
  def facet_configuration_for_field(field)
    Blacklight::Configuration::FacetField.new(:field => field, :label => field.titleize)
  end
  
end
