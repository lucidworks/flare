module SearchHistoryConstraintsHelper
  include Blacklight::SearchHistoryConstraintsHelperBehavior

  # Override this method to allow the search history page to work properly when facets are not defined in the blacklight_config
  # TODO: submit this change back.  the only difference is using facet_configuration_for_field(facet_field) instead of blacklight_config.facet_fields[facet_field]
  def render_search_to_s_filters(params)
    return "".html_safe unless params[:f]

    params[:f].collect do |facet_field, value_list|
      render_search_to_s_element(facet_configuration_for_field(facet_field).label,
        value_list.collect do |value|
          render_filter_value(value)
        end.join(content_tag(:span, " #{t('blacklight.and')} ", :class =>'filterSeparator')).html_safe
      )
    end.join(" \n ").html_safe
  end
end

