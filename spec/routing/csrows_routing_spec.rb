require "spec_helper"

describe CsrowsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/csrows" }.should route_to(:controller => "csrows", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/csrows/new" }.should route_to(:controller => "csrows", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/csrows/1" }.should route_to(:controller => "csrows", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/csrows/1/edit" }.should route_to(:controller => "csrows", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/csrows" }.should route_to(:controller => "csrows", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/csrows/1" }.should route_to(:controller => "csrows", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/csrows/1" }.should route_to(:controller => "csrows", :action => "destroy", :id => "1")
    end

  end
end
