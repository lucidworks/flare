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
  
  def render_selected_facet_value(facet_solr_field, item)
    #Updated class for Bootstrap Blacklight
    content_tag(:span, render_facet_value(facet_solr_field, item, :suppress_link => true)) +
     link_to(content_tag(:i, '', :class => "icon-remove") + content_tag(:span, '[remove]', :class => 'hide-text'), remove_facet_params(facet_solr_field, item, params), :class=>"remove")
  end
end
