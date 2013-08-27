module RenderConstraintsHelper
  include Blacklight::RenderConstraintsHelperBehavior

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
