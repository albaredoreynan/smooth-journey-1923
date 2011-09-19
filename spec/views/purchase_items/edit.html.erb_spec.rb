require 'spec_helper'

describe "purchase_items/edit.html.erb" do
  before(:each) do
    @purchase_item = assign(:purchase_item, stub_model(PurchaseItem,
      :new_record? => false,
      :purchase_unitCost => 1.5,
      :vat_amount => 1.5,
      :net_amount => 1.5,
      :purchase_quantity => 1.5,
      :purchase_remarks => "MyString",
      :purchase_item => "MyString",
      :invoice_id => 1,
      :inventory_id => 1,
      :vat_type => "MyString",
      :unit_id => 1
    ))
  end

  it "renders the edit purchase_item form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => purchase_item_path(@purchase_item), :method => "post" do
      assert_select "input#purchase_item_purchase_unitCost", :name => "purchase_item[purchase_unitCost]"
      assert_select "input#purchase_item_vat_amount", :name => "purchase_item[vat_amount]"
      assert_select "input#purchase_item_net_amount", :name => "purchase_item[net_amount]"
      assert_select "input#purchase_item_purchase_quantity", :name => "purchase_item[purchase_quantity]"
      assert_select "input#purchase_item_purchase_remarks", :name => "purchase_item[purchase_remarks]"
      assert_select "input#purchase_item_purchase_item", :name => "purchase_item[purchase_item]"
      assert_select "input#purchase_item_invoice_id", :name => "purchase_item[invoice_id]"
      assert_select "input#purchase_item_inventory_id", :name => "purchase_item[inventory_id]"
      assert_select "input#purchase_item_vat_type", :name => "purchase_item[vat_type]"
      assert_select "input#purchase_item_unit_id", :name => "purchase_item[unit_id]"
    end
  end
end
