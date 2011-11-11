require 'spec_helper'

describe "settlement_types/new.html.erb" do
  before(:each) do
    assign(:settlement_type, stub_model(SettlementType,
      :st_name => "MyString"
    ).as_new_record)
  end

  it "renders new settlement_type form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => settlement_types_path, :method => "post" do
      assert_select "input#settlement_type_st_name", :name => "settlement_type[st_name]"
    end
  end
end
