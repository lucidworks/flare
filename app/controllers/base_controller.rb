class BaseController < ApplicationController
  abstract!
  
  include BaseHelper

  helper_method :current_collection
  
  def current_collection
    collection_id = params[:collection_id] 
    @current_collection ||= current_server.collection(collection_id) if collection_id
  end
end