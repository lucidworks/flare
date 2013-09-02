class CollectionsController < BaseController
  layout 'lws_blacklight'

  def index
    @collections = current_server.collections.select {|collection| !collection.system?} 
  end
end