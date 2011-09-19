require "spec_helper"

describe SettlementSalesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/settlement_sales" }.should route_to(:controller => "settlement_sales", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/settlement_sales/new" }.should route_to(:controller => "settlement_sales", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/settlement_sales/1" }.should route_to(:controller => "settlement_sales", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/settlement_sales/1/edit" }.should route_to(:controller => "settlement_sales", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/settlement_sales" }.should route_to(:controller => "settlement_sales", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/settlement_sales/1" }.should route_to(:controller => "settlement_sales", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/settlement_sales/1" }.should route_to(:controller => "settlement_sales", :action => "destroy", :id => "1")
    end

  end
end
