require 'sinatra/base'
require 'net/http'
require 'net/https'
require 'cgi'

# require 'solr'
# require 'velaro'

module Lucid  
  class Prism < Sinatra::Base
    
    # Use the Rack session so that it overlaps with the Rails/Blacklight one
    use Rack::Session::Pool

    helpers do
      def h(text)
        Rack::Utils.escape_html(text)
      end
    end

    # TODO: see if this is the way to go to integrate Blacklight context with Sinatra, then centralize this across CatalogController
    include Blacklight::SolrHelper
    include Blacklight::Configurable
    copy_blacklight_config_from(CatalogController) # useful obscure necessity to pick up the common config

    # blacklight_solr needed from Blacklight's catalog.rb    
    def blacklight_solr
      @solr ||=  RSolr.connect(blacklight_solr_config)
    end

    # And this is borrowed exactly from our catalog controller override implementation
    def blacklight_solr_config
      # Make the Solr URL dynamic based on the users session set collection, removes need/use of config/solr.yml
      # TODO: need to see how this will affect test runs
      # See also use of ENV['LWS_...'] in collection_manager_controller
      url ||= ENV['LWS_SOLR_URL']
      url ||= "#{ENV['LWS_CORE_URL']}/solr" if ENV['LWS_CORE_URL']
      {:url => "#{url || 'http://127.0.0.1:8888/solr'}/#{session[:collection]}"}
    end
    
    set :root, '/Users/erikhatcher/dev/lws_blacklight' # TODO: make relative/dynamic
    set :views, Proc.new { File.join(root, 'app/views') }
    # set :erb, :layout => :"layouts/application.html"    

    # Simple demonstration pass-through templating of the Blacklight configured Solr and request parameterization      
    get '/test' do
      (@search_results, @document_list) = get_search_results()
      # Blacklight/Rails returns @response, but Sinatra frowns upon using @response
      
      erb :"prism/test.html"
    end
  end
end


#       # TODO: gotta figure out what to do about using Sinatra's settings.views configuration somehow...
#       # TODO: but currently experimenting, since we're only using Velocity here for now, with fixing the Velocity(/Velaro) resource loader path custom below
#       set :public_folder, ENV['PRISM_PUBLIC'] || './public'
#       set :views, ENV['PRISM_VIEWS'] || './views'
#       
#       set :velocity, {
#          :'file.resource.loader.path' => ENV['PRISM_VELOCITY_FILE_RESOURCE_LOADER_PATH'] || './views/solr',
#          :'resource.loader' => 'file'
#        }
# 
#       SOLR_BASE_URL = ENV['PRISM_SOLR_BASE_URL'] || 'http://localhost:8983/solr' # TODO:unDRY alert:this is duplicated in lucid_works.rb - centralize.
#       
# #      use Lucid::Prism::LucidWorks # TODO: inject this dynamically somehow rather than hardcoding - via Rack middleware config?
#       # TODO:and how to automatically namespace-prefix these types of plugins?  e.g. /lucid/ + routes in Prism::LucidWorks
# 
#       # Solr direct pass-thru; response code, headers including content-type, and Solr response body all included
#       # TODO: this needs to be made optional, and perhaps only default it on when in development mode
#       get '/solr/?:core?/?:handler?' do
#         solr_core = params[:core] ? ('/' + params[:core]) : ''
#         solr_url = "#{SOLR_BASE_URL}#{solr_core}"
#         http_response = solr(solr_url, params[:handler] || 'select', params)
# 
#         [http_response.code.to_i, http_response.to_hash, http_response.body]
#       end
#       
#       get '/prism/?:core?/?:handler?' do
#         # TODO:centralize this Solr calling pattern as used above also
#         solr_core = params[:core] ? ('/' + params[:core]) : ''
#         solr_url = "#{SOLR_BASE_URL}#{solr_core}"
# 
#         solr_params = {}
#         params.each {|key,value| solr_params[key] = value unless %w{splat captures core template handler}.include?(key) }
# 
#         http_response = solr(solr_url, params[:handler] || 'select', solr_params.merge(:wt=>:ruby, :'json.nl'=>:map))
#         solr_response = eval(http_response.body) rescue ""
#         
#         velaro params[:template] || params[:handler] || :prism,
#           :locals => {
#             :solr => {
#               # TODO: string keys required for now, but symbols should be made to work
#               'response' => solr_response,
#               'results' => solr_response['response'], 
#               'header' => solr_response['responseHeader'], 
#               'raw_response' => http_response.body,
#               'debug' => solr_response['debug'] || {},
#               'url' => solr_url,
#               'params' => solr_params,
#             },
#             :params => params,
#           },
#           
#           :layout => 'layout', # TODO: parameterize layout
# 
#           # Velocity engine parameters
#           :velocity => settings.velocity
#       end
#       
#       post '/update' do
#         "not supported"
#         # TODO: process multiparts
#       end
#     end
#   end
