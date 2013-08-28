require 'lucid/prism' 

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
  
  # Prism's goal is to allow straight-forward templated "pass-through" of Solr responses  
  match "prism" => Lucid::Prism, :anchor => false 
  
  root :to => "collections#index"
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
