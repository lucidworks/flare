Blacklight::SolrHelper.module_eval do
  # As get_search_results and query_solr do not take additional options to pass along
  # to RSolr's send_and_receive, they are patched here to take an additional arg to do so.
  # We need this in order to pass along the :headers key for auth as per FOCUS-5578.
  
  def get_search_results(user_params = params || {}, extra_controller_params = {}, opts = {})
    Rails.logger.info("*** Using patched Blacklight::SolrHelper.get_search_results")
    solr_response = query_solr(user_params, extra_controller_params, opts)
    document_list = solr_response.docs.collect {|doc| SolrDocument.new(doc, solr_response)} 
    return [solr_response, document_list]
  end

  def query_solr(user_params = params || {}, extra_controller_params = {}, opts = {})
    Rails.logger.info("*** Using patched Blacklight::SolrHelper.query_solr")
    # In later versions of Rails, the #benchmark method can do timing
    # better for us. 
    bench_start = Time.now
    solr_params = self.solr_search_params(user_params).merge(extra_controller_params)
    solr_params[:qt] ||= blacklight_config.qt
    path = blacklight_config.solr_path
    
    options = opts.merge({params: solr_params})
    # delete these parameters, otherwise rsolr will pass them through.
    res = blacklight_solr.send_and_receive(path, options)
    
    solr_response = Blacklight::SolrResponse.new(force_to_utf8(res), solr_params)

    Rails.logger.debug("Solr query: #{solr_params.inspect}")
    Rails.logger.debug("Solr response: #{solr_response.inspect}") if defined?(::BLACKLIGHT_VERBOSE_LOGGING) and ::BLACKLIGHT_VERBOSE_LOGGING
    Rails.logger.debug("Solr fetch: #{self.class}#query_solr (#{'%.1f' % ((Time.now.to_f - bench_start.to_f)*1000)}ms)")
    

    solr_response
  end
end