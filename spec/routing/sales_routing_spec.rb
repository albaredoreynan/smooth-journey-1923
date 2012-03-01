require 'spec_helper'

describe SalesController do

  it 'should route #index' do
    { :get => 'sales' }.should route_to(:controller => 'sales', :action => 'index')
  end

  it 'should route sales by settlement types' do
    { :get => 'sales/settlement_types' }.should route_to(:controller => 'sales', :action => 'settlement_types')
  end
end
