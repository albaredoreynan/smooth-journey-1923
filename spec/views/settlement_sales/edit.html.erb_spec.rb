require 'spec_helper'

describe "settlement_sales/edit.html.erb" do
  before(:each) do
    @settlement_sale = assign(:settlement_sale, stub_model(SettlementSale,
      :new_record? => false,
      :ss_amount => 1.5,
      :st_id => 1,
      :stemployee_id => 1,
      :vat => 1.5,
      :void => 1.5,
      :ss_revenue => 1.5,
      :customerCount => 1,
      :transactionCount => 1
    ))
  end

  it "renders the edit settlement_sale form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => settlement_sale_path(@settlement_sale), :method => "post" do
      assert_select "input#settlement_sale_ss_amount", :name => "settlement_sale[ss_amount]"
      assert_select "input#settlement_sale_st_id", :name => "settlement_sale[st_id]"
      assert_select "input#settlement_sale_stemployee_id", :name => "settlement_sale[stemployee_id]"
      assert_select "input#settlement_sale_vat", :name => "settlement_sale[vat]"
      assert_select "input#settlement_sale_void", :name => "settlement_sale[void]"
      assert_select "input#settlement_sale_ss_revenue", :name => "settlement_sale[ss_revenue]"
      assert_select "input#settlement_sale_customerCount", :name => "settlement_sale[customerCount]"
      assert_select "input#settlement_sale_transactionCount", :name => "settlement_sale[transactionCount]"
    end
  end
end
