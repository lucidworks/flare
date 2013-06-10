# Overrides to Blacklight's constraint rendering handling
#     - to label constraints with the nature of the restraint

module RenderConstraintsHelper
  include Blacklight::RenderConstraintsHelperBehavior

  def render_constraints_query(localized_params = params)
    # So simple don't need a view template, we can just do it here.
    if (!localized_params[:q].blank?)
      label = 
        if (localized_params[:search_field].blank? || (default_search_field && localized_params[:search_field] == default_search_field[:key] ) )
          nil
        else
          label_for_search_field(localized_params[:search_field])
        end
    
      render_constraint_element("Query",
            localized_params[:q], 
            :classes => ["query"], 
            :remove => url_for(localized_params.merge(:q=>nil, :action=>'index')))
    else
      "".html_safe
    end
  end


  def render_filter_element(facet, values, localized_params)
    facet_config = facet_configuration_for_field(facet)

    values.map do |val|

      render_constraint_element("Facet",
                  facet_display_value(facet, val), 
                  :remove => url_for(remove_facet_params(facet, val, localized_params)),
                  :classes => ["filter", "filter-" + facet.parameterize] 
                ) + "\n"                 					            
    end
  end
end
