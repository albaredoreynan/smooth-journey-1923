require 'spec_helper'

describe PurchaseItemsController do

  it 'should routes to POST purchase/:purchase_id/purchase_items' do
    { :post => '/purchases/1/purchase_items' }.
      should route_to(:controller => 'purchase_items', :action => 'create', :purchase_id => '1')
  end

  it 'should routes PUT purchases/:purchase_id/purchase_items/:id' do
    { :put => '/purchases/1/purchase_items/2' }.
      should route_to(:controller => 'purchase_items', :action => 'update', :purchase_id => '1', :id => '2')
  end

  it 'should routes DELETE purchases/:purchase_id/purchase_items/:id' do
    { :delete => '/purchases/1/purchase_items/2' }.
      should route_to(:controller => 'purchase_items', :action => 'destroy', :purchase_id => '1', :id => '2')
  end

  it 'should route POST purchase_items/validate' do
    { :post => '/purchase_items/validate' }.
      should route_to(:controller => 'purchase_items', :action => 'validate' )
  end
end
