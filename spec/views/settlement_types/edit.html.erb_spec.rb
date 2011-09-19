require 'spec_helper'

describe "settlement_types/edit.html.erb" do
  before(:each) do
    @settlement_type = assign(:settlement_type, stub_model(SettlementType,
      :new_record? => false,
      :st_name => "MyString"
    ))
  end

  it "renders the edit settlement_type form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => settlement_type_path(@settlement_type), :method => "post" do
      assert_select "input#settlement_type_st_name", :name => "settlement_type[st_name]"
    end
  end
end
