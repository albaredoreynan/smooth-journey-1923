require "spec_helper"

describe SettlementTypesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/settlement_types" }.should route_to(:controller => "settlement_types", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/settlement_types/new" }.should route_to(:controller => "settlement_types", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/settlement_types/1" }.should route_to(:controller => "settlement_types", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/settlement_types/1/edit" }.should route_to(:controller => "settlement_types", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/settlement_types" }.should route_to(:controller => "settlement_types", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/settlement_types/1" }.should route_to(:controller => "settlement_types", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/settlement_types/1" }.should route_to(:controller => "settlement_types", :action => "destroy", :id => "1")
    end

  end
end
