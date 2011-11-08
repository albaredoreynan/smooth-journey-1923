Rrbs::Application.routes.draw do

  resources :conversions

  resources :jobs

  resources :branches

  resources :sales

  resources :companies

  resources :restaurantcategories

  resources :restaurants

  resources :roles

  resources :suppliers

  resources :reporttemplates

  devise_for :users

  resources :csrows

  resources :ecrows

  resources :ssrows

  root :to => "index#index"

  resources :settlement_types

  resources :settlement_sales

  resources :employees

  resources :subcategories

  resources :categories

  resources :sales_reports

  resources :purchaseitems

  resources :purchases

  resources :inventoryitems

  resources :units

  resources :reports

  resources :users

  resources :endcounts

  #resources :javascripts

  match "/purchaseitems/search" => "purchaseitems#index"

  match "/purchaseitems/index" => "purchaseitems#index", :as => :purchaseitems_index

  match "/endcounts/search" => "endcounts#index"

  match "/purchases/search" => "purchases#index"


  #match "/endcounts/index" => "endcounts#index", :as => :endcounts_index #don't include, messes up search then save

  match "/reports" => "reports#index"

  #resources :purchaseitems, :collection => { :savemultiple => :put }

  match '/purchaseitems/savemultiple' => "purchaseitems#index", :collection => { :savemultiple => :put }

  match '/purchases/savemultiple' => "purchases#index", :collection => { :savemultiple => :put }

  match '/endcounts/savechecked' => "endcounts#index", :collection => { :savechecked => :put }

  match '/sales/savemultiple' => "sales#sales_by_server", :collection => { :savemultiple => :put }
  #resources :endcounts, :collection => { :savechecked => :put }

  resources :purchaseitems do
	collection do
		get 'search'
	end
  end

  resources :endcounts do
  collection do
    get 'search'
  end
  end

  match '/sales_reports/daily_sales' => "sales_reports#daily_sales", :as => :sales_reports_daily_sales

  match "/sales/search" => "sales#index", :as => :sales_index

  match '/serversales' => "settlement_sales#serversales", :as => :serversales

  match '/serversales/search' => "settlement_sales#serversales_search", :as => :serversales_search

  match '/salesbysettlementtype' => "sales#sales_by_settlement_type", :as => :sales_by_settlement_type

  match '/categorysales' => "reports#categorysales", :as => :categorysales

  match '/purchasereports' => "reports#purchasereports", :as => :purchasereports

  match '/purchasereports/search' => "reports#purchasereports", :as => :purchasereports

  match '/salesbyserver' => "sales#sales_by_server", :as => :sales_by_server

  match '/settlement_sales/search' => "settlement_sales#search", :as => :settlement_sales_search

  #match '/reports/categorysales' => "reports#categorysales", :as => :categorysales_report_path

  match '/reports/search'=>"reports#index"

  match '/employees' => "employees#index" ,:as => :employees_path

  resources :categorysales do
    collection do
     get 'search'
    end
   end




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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
