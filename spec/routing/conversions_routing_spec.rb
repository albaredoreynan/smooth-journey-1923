require "spec_helper"

describe ConversionsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/conversions" }.should route_to(:controller => "conversions", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/conversions/new" }.should route_to(:controller => "conversions", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/conversions/1" }.should route_to(:controller => "conversions", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/conversions/1/edit" }.should route_to(:controller => "conversions", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/conversions" }.should route_to(:controller => "conversions", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/conversions/1" }.should route_to(:controller => "conversions", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/conversions/1" }.should route_to(:controller => "conversions", :action => "destroy", :id => "1")
    end

  end
end
