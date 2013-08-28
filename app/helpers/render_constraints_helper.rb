module RenderConstraintsHelper
  include Blacklight::RenderConstraintsHelperBehavior
  
  def has_query?(localized_params = params)
    !(localized_params[:q].blank?)
  end
  
  def query_has_filters?(localized_params = params)
    !(localized_params[:f].blank?)
  end
  
  def render_constraints_query(localized_params = params)
    # So simple don't need a view template, we can just do it here.
    if (!localized_params[:q].blank?)
      label =
        if (localized_params[:search_field].blank? || (default_search_field && localized_params[:search_field] == default_search_field[:key] ) )
          nil
        else
          label_for_search_field(localized_params[:search_field])
        end
        
        content_tag :span, localized_params[:q], :class => 'applied-filter constraint query'
    else
      content_tag :span, '*:*', :class => 'applied-filter constraint query'
    end
  end
  
  def render_constraints_filters(localized_params = params)
     return "".html_safe unless localized_params[:f]
     content = ["<dl id=\"applied-filters\" class=\"dl-horizontal collapse out\">\n"]
     localized_params[:f].each_pair do |facet,values|
       content << content_tag(:dt, content_tag(:span, facet.parameterize, :class => 'filter-name'))
       content << content_tag(:dd, render_filter_element(facet, values, localized_params).flatten.join("\n").html_safe)
     end 
     
     content << "</dl>\n"
     return content.flatten.join("\n").html_safe    
  end
end
