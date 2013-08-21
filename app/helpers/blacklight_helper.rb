module BlacklightHelper
  include Blacklight::BlacklightHelperBehavior
  
  # Index fields to display for a type of document
  def index_fields document=nil
    # overridden to provide the fields from the response, not from config
    # TODO: blend this with blacklight_config.index_fields for UI app control too
    
    fields = {}
    
    document.except("[elevated]", "[excluded]").keys.each {|f| 
      fields[f] = Blacklight::Configuration::SolrField.new(:field => f, :label => f)
    }
        
    fields
  end
  
  ##
  # Render the index field value for a document
  #
  # @overload render_index_field_value(options)
  #   Use the default, document-agnostic configuration
  #   @param [Hash] opts
  #   @options opts [String] :field
  #   @options opts [String] :value
  #   @options opts [String] :document
  # @overload render_index_field_value(document, options)
  #   Allow an extention point where information in the document
  #   may drive the value of the field
  #   @param [SolrDocument] doc
  #   @param [Hash] opts
  #   @options opts [String] :field 
  #   @options opts [String] :value
  # @overload render_index_field_value(document, field, options)
  #   Allow an extention point where information in the document
  #   may drive the value of the field
  #   @param [SolrDocument] doc
  #   @param [String] field
  #   @param [Hash] opts
  #   @options opts [String] :value
  def render_index_field_value *args
    # This method was overridden to allow highlighting to render from the response without require app-level specification (/lucid will have it set already and LWS allows turning it on or off per field)
    options = args.extract_options!
    document = args.shift || options[:document]

    field = args.shift || options[:field]
    value = options[:value]


    field_config = index_fields(document)[field]

    value ||= case 
      when value
        value
      when (field_config and field_config.helper_method)
        send(field_config.helper_method, options.merge(:document => document, :field => field))
      when (document.has_highlight_field?(field))  # LWS Note: this line customized was customized to pick up any fields that have highlighting values rather than through config
        document.highlight_field(field_config.field).map { |x| x.html_safe }
      else
        document.get(field, :sep => nil) if field
    end

    render_field_value value
  end
end
