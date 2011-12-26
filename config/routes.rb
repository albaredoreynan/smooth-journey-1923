Rrbs::Application.routes.draw do
  devise_for :users

  match '/purchases/search' => 'purchases#index'

  match '/endcounts/search' => 'endcounts#index'

  match '/sales/search' => 'sales#index'

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

  resources :sales_reports

  resources :purchases do
    resources :purchase_items
  end

  resources :inventoryitems

  resources :units

  resources :reports

  resources :users

  resources :endcounts do
    collection do
      get 'search'
      put 'update_item_counts'
    end
  end

  match "/reports" => "reports#index"

  match '/purchases/savemultiple' => "purchases#index", :collection => { :savemultiple => :put }

  match '/endcounts/savechecked' => "endcounts#index", :collection => { :savechecked => :put }

  match '/sales/savemultiple' => "sales#sales_by_server", :collection => { :savemultiple => :put }

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

  root :to => 'home#index'
end
