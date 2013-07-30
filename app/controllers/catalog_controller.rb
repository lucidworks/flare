# -*- encoding : utf-8 -*-
require 'blacklight/catalog'

class CatalogController < ApplicationController  

  include Blacklight::Catalog

  configure_blacklight do |config|
    ## Default parameters to send to solr for all search-like requests. See also SolrHelper#solr_search_params
    config.default_solr_params = { 
      :qt => '/lucid',
      :'hl.simple.pre' => '<b>',
      :'hl.simple.post' => '</b>',
      :req_type => 'main', # see http://docs.lucidworks.com/display/lweug/Constructing+Solr+Queries
      :'hl.fragsize' => 250,
      :rows => 10
    }

    ## Default parameters to send on single-document requests to Solr. These settings are the Blackligt defaults (see SolrHelper#solr_doc_params) or 
    ## parameters included in the Blacklight-jetty document requestHandler.
    config.default_document_solr_params = {
     :qt => '/lucid',
     :fl => '*',
     :rows => 1,
     :q => '{!raw f=id v=$id}' 
    }

    ## solr field configuration for search results/index views
    # config.index.show_link = 'name'
    # config.index.record_display_type = 'format'

    ## solr field configuration for document/show views
    # config.show.html_title = 'name'
    # config.show.heading = 'name'
    # config.show.display_type = 'format'

    # solr fields that will be treated as facets by the blacklight application
    #   The ordering of the field names is the order of the display
    #
    # Setting a limit will trigger Blacklight's 'more' facet values link.
    # * If left unset, then all facet values returned by solr will be displayed.
    # * If set to an integer, then "f.somefield.facet.limit" will be added to
    # solr request, with actual solr request being +1 your configured limit --
    # you configure the number of items you actually want _displayed_ in a page.    
    # * If set to 'true', then no additional parameters will be sent to solr,
    # but any 'sniffed' request limit parameters will be used for paging, with
    # paging at requested limit -1. Can sniff from facet.limit or 
    # f.specific_field.facet.limit solr request params. This 'true' config
    # can be used if you set limits in :default_solr_params, or as defaults
    # on the solr side in the request handler itself. Request handler defaults
    # sniffing requires solr requests to be made with "echoParams=all", for
    # app code to actually have it echo'd back to see it.  
    #
    # :show may be set to false if you don't want the facet to be drawn in the 
    # facet bar
    # config.add_facet_field 'author_display', :label=> 'Author'
    # config.add_facet_field 'mimeType', :label=> 'Document Type'

    # config.add_facet_field 'example_pivot_field', :label => 'Pivot Field', :pivot => ['format', 'language_facet']

    # config.add_facet_field 'example_query_facet_field', :label => 'Publish Date', :query => {
    #    :years_5 => { :label => 'within 5 Years', :fq => "pub_date:[#{Time.now.year - 5 } TO *]" },
    #    :years_10 => { :label => 'within 10 Years', :fq => "pub_date:[#{Time.now.year - 10 } TO *]" },
    #    :years_25 => { :label => 'within 25 Years', :fq => "pub_date:[#{Time.now.year - 25 } TO *]" }
    # }

    ## Have BL send all facet field names to Solr, which has been the default
    ## previously. Simply remove these lines if you'd rather use Solr request
    ## handler defaults, or have no facets.
    # config.add_facet_fields_to_solr_request!

    ## solr fields to be displayed in the index (search results) view
    ##   The ordering of the field names is the order of the display 
    # config.add_index_field 'body', :label => 'Body:'  # this was made unnecessary by changes to BlacklightHelper

    # solr fields to be displayed in the show (single result) view
    #   The ordering of the field names is the order of the display 
    config.add_show_field 'description', :label => 'Description:' 

    # "fielded" search configuration. Used by pulldown among other places.
    # For supported keys in hash, see rdoc for Blacklight::SearchFields
    #
    # Search fields will inherit the :qt solr request handler from
    # config[:default_solr_parameters], OR can specify a different one
    # with a :qt key/value. Below examples inherit, except for subject
    # that specifies the same :qt as default for our own internal
    # testing purposes.
    #
    # The :key is what will be used to identify this BL search field internally,
    # as well as in URLs -- so changing it after deployment may break bookmarked
    # urls.  A display label will be automatically calculated from the :key,
    # or can be specified manually to be different. 

    # This one uses all the defaults set by the solr request handler. Which
    # solr request handler? The one set in config[:default_solr_parameters][:qt],
    # since we aren't specifying it otherwise. 
    
    config.add_search_field 'all_fields', :label => 'All Fields'
    

    # Now we see how to over-ride Solr request handler defaults, in this
    # case for a BL "search field", which is really a dismax aggregate
    # of Solr search fields. 
    
    config.add_search_field('title') do |field|
      field.solr_parameters = { :qf => 'title', :pf => 'title' }
    end
    
    config.add_search_field('author') do |field|
      field.solr_parameters = { :qf => 'author', :pf => 'author' }
    end
    
    # "sort results by" select (pulldown)
    # label in pulldown is followed by the name of the SOLR field to sort by and
    # whether the sort is ascending or descending (it must be asc or desc
    # except in the relevancy case).
    config.add_sort_field 'score desc', :label => 'relevance'
    config.add_sort_field 'lastModified desc', :label => 'Last modified'

    # If there are more than this many search results, no spelling ("did you 
    # mean") suggestion is offered.
    config.spell_max = 5
  end



end 
