require "spec_helper"

describe UsersController do
  describe "routing" do
    it "should route GET /members" do
      { :get => "/members" }.should route_to(:controller => "users", :action => "index")
    end

    it "should route POST /members" do
      { :post => "/members" }.should route_to(:controller => "users", :action => "create")
    end
  end
end
