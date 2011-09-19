require "spec_helper"

describe SsrowsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/ssrows" }.should route_to(:controller => "ssrows", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/ssrows/new" }.should route_to(:controller => "ssrows", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/ssrows/1" }.should route_to(:controller => "ssrows", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/ssrows/1/edit" }.should route_to(:controller => "ssrows", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/ssrows" }.should route_to(:controller => "ssrows", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/ssrows/1" }.should route_to(:controller => "ssrows", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/ssrows/1" }.should route_to(:controller => "ssrows", :action => "destroy", :id => "1")
    end

  end
end
