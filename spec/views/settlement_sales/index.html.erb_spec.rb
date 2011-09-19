require 'spec_helper'

describe "settlement_sales/index.html.erb" do
  before(:each) do
    assign(:settlement_sales, [
      stub_model(SettlementSale,
        :ss_amount => 1.5,
        :st_id => 1,
        :stemployee_id => 1,
        :vat => 1.5,
        :void => 1.5,
        :ss_revenue => 1.5,
        :customerCount => 1,
        :transactionCount => 1
      ),
      stub_model(SettlementSale,
        :ss_amount => 1.5,
        :st_id => 1,
        :stemployee_id => 1,
        :vat => 1.5,
        :void => 1.5,
        :ss_revenue => 1.5,
        :customerCount => 1,
        :transactionCount => 1
      )
    ])
  end

  it "renders a list of settlement_sales" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
