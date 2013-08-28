class CollectionsController < BaseController
  layout 'lws_blacklight'

  def index
    @collections = build_collections 
  end
end