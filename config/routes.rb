Rrbs::Application.routes.draw do
  devise_for :users, :controller => {:registrations => 'users/registrations'}

  # Search routes
  match '/purchases/search' => 'purchases#index'
  match '/endcounts/search' => 'endcounts#index'
  match '/sales/search' => 'sales#index'
  match '/serversales/search' => "settlement_sales#serversales_search", :as => :serversales_search
  match '/settlement_sales/search' => "settlement_sales#search", :as => :settlement_sales_search

  match '/settings' => 'settings#index'
  put '/settings/update'

  resources :currencies

  resources :conversions

  resources :jobs

  resources :branches

  resources :sales

  resources :companies

  resources :restaurants

  resources :roles

  resources :suppliers

  resources :settlement_types

  resources :settlement_sales

  resources :employees

  resources :subcategories

  resources :categories

  resources :purchases do
    resources :purchase_items
  end

  match '/purchase_items/validate', :to => 'purchase_items#validate', :via => :post

  resources :inventoryitems do
    get 'available_units', :on => :member
  end

  resources :units

  match '/reports/endcounts', :to => 'reports/endcount_reports#index', :as => 'endcount_reports'
  match '/reports/purchases', :to => 'reports/purchase_reports#index', :as => 'purchase_reports'

  match "/members", :to => "users#index", :via => "get"
  match "/members", :to => "users#create", :via => "post"

  resources :users

  resources :endcounts do
    collection do
      get 'search'
      put 'update_item_counts'
    end
  end

  root :to => 'home#index'
end
