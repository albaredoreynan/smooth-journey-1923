require "spec_helper"

describe InventoryitemsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/inventoryitems/1/available_units" }.should route_to(:controller => "inventoryitems", :action => "available_units", :id => "1")
    end  end
end
