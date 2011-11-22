require "spec_helper"

describe PurchasesController do

    it 'should route GET /purchases' do
      { :get => "/purchases" }.
        should route_to(:controller => "purchases", :action => "index")
    end

    it 'should route GET /purchases/new' do
      { :get => "/purchases/new" }.
        should route_to(:controller => "purchases", :action => "new")
    end

    it 'should route GET /purchases/:id' do
      { :get => "/purchases/1" }.
        should route_to(:controller => "purchases", :action => "show", :id => "1")
    end

    it 'should route GET /purchases/:id/edit' do
      { :get => "/purchases/1/edit" }.
        should route_to(:controller => "purchases", :action => "edit", :id => "1")
    end

    it 'should route GET /purchases/search' do
      { :get => '/purchases/search?start=2011-11-11&end=2011-11-12' }.
        should route_to :controller => 'purchases', :action => 'index'
    end

    it 'should route POST /purchases' do
      { :post => "/purchases" }.
        should route_to(:controller => "purchases", :action => "create")
    end

    it 'should route PUT /purcheses/:id' do
      { :put => "/purchases/1" }.
        should route_to(:controller => "purchases", :action => "update", :id => "1")
    end

    it 'should route DELETE /purchases/:id' do
      { :delete => "/purchases/1" }.
        should route_to(:controller => "purchases", :action => "destroy", :id => "1")
    end

end
