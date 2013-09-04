LwsBlacklight::Application.routes.draw do
  # /catalog/* route definitions, so tht /catalog/:collection_id can be used wildcardly
  # Commented out default ones from Blacklight that we don't want in there (for now at least)
  get 'catalog/opensearch', :as => "opensearch_catalog"
  # get 'catalog/citation', :as => "citation_catalog"
  get 'catalog/email', :as => "email_catalog"
  post 'catalog/email'
  # get 'catalog/sms', :as => "sms_catalog"
  # get 'catalog/endnote', :as => "endnote_catalog"
  # get 'catalog/send_email_record', :as => "send_email_record_catalog"
  get "catalog/facet/:id", :to => 'catalog#facet', :as => 'catalog_facet'
  get "catalog", :to => 'catalog#index', :as => 'catalog_index'
  # get 'catalog/:id/librarian_view', :to => "catalog#librarian_view", :as => "librarian_view_catalog"

  # LWS collection selection
  get 'catalog/:collection_id', :to => 'catalog#index', :as => 'collection' 

  # NOT /bookmarks/file:/Users/erikhatcher/Documents/Test/LucidWorks%20Enterprise%20User%20Guide.pdf
  # but rather PUT /bookmarks?id=.... etc
  get 'bookmarks' => 'bookmarks#index', :as => 'bookmarks'
  delete 'bookmarks/clear' => 'bookmarks#clear', :as => 'clear_bookmarks'
  put 'bookmark' => 'bookmarks#create', :as => 'bookmark'
  delete 'bookmark' => 'bookmarks#destroy', :as => 'bookmark'

  Blacklight.add_routes(self, :except => [:bookmarks, :catalog])
  
  devise_for :users
  
  root :to => "collections#index"
end
