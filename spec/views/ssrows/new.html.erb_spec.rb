require 'spec_helper'

describe "ssrows/new.html.erb" do
  before(:each) do
    assign(:ssrow, stub_model(Ssrow,
      :st_id => 1,
      :ss_amount => 1.5
    ).as_new_record)
  end

  it "renders new ssrow form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => ssrows_path, :method => "post" do
      assert_select "input#ssrow_st_id", :name => "ssrow[st_id]"
      assert_select "input#ssrow_ss_amount", :name => "ssrow[ss_amount]"
    end
  end
end
