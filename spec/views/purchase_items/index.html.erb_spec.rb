require 'spec_helper'

describe "purchase_items/index.html.erb" do
  before(:each) do
    assign(:purchase_items, [
      stub_model(PurchaseItem,
        :purchase_unitCost => 1.5,
        :vat_amount => 1.5,
        :net_amount => 1.5,
        :purchase_quantity => 1.5,
        :purchase_remarks => "Purchase Remarks",
        :purchase_item => "Purchase Item",
        :invoice_id => 1,
        :inventory_id => 1,
        :vat_type => "Vat Type",
        :unit_id => 1
      ),
      stub_model(PurchaseItem,
        :purchase_unitCost => 1.5,
        :vat_amount => 1.5,
        :net_amount => 1.5,
        :purchase_quantity => 1.5,
        :purchase_remarks => "Purchase Remarks",
        :purchase_item => "Purchase Item",
        :invoice_id => 1,
        :inventory_id => 1,
        :vat_type => "Vat Type",
        :unit_id => 1
      )
    ])
  end

  it "renders a list of purchase_items" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Purchase Remarks".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Purchase Item".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Vat Type".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
