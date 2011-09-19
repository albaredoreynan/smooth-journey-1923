require 'spec_helper'

describe "purchase_items/show.html.erb" do
  before(:each) do
    @purchase_item = assign(:purchase_item, stub_model(PurchaseItem,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Purchase Remarks/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Purchase Item/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Vat Type/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
