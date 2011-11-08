require 'spec_helper'

describe "purchases/new.html.erb" do
  before(:each) do
    assign(:purchase, stub_model(Purchase,
      :invoice_id => 1,
      :supplier_id => 1,
      :branch_id => 1,
      :save_as_draft => 1
    ).as_new_record)
  end

  it "renders new purchase form" do
    pending 'fail'
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => purchases_path, :method => "post" do
      assert_select "input#purchase_invoice_id", :name => "purchase[invoice_id]"
      assert_select "input#purchase_supplier_id", :name => "purchase[supplier_id]"
      assert_select "input#purchase_branch_id", :name => "purchase[branch_id]"
      assert_select "input#purchase_save_as_draft", :name => "purchase[save_as_draft]"
    end
  end
end
