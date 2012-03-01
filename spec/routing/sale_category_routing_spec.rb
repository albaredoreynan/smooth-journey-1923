require 'spec_helper'

describe SaleCategoriesController do

  it 'should route #index' do
    { :get => 'sales/categories' }.should route_to(:controller => 'sale_categories', :action => 'index')
  end

  it 'should route #new' do
    { :get => 'sales/categories/new' }.should route_to(:controller => 'sale_categories', :action => 'new')
  end

  it 'should route to #create' do
    { :post => 'sales/categories' }.should route_to(:controller => 'sale_categories', :action => 'create')
  end

  it 'shoul route to #update' do
    { :put => 'sales/category/1' }.should route_to(:controller => 'sale_categories', :action => 'update', :id => '1')
  end

  it 'should recognize edit_sale_category(id) path' do
    edit_sale_category_path(1).should == '/sales/categories/1/edit'
  end
end
