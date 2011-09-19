require 'spec_helper'

describe "csrows/new.html.erb" do
  before(:each) do
    assign(:csrow, stub_model(Csrow,
      :cs_id => 1,
      :cs_amount => 1.5
    ).as_new_record)
  end

  it "renders new csrow form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => csrows_path, :method => "post" do
      assert_select "input#csrow_cs_id", :name => "csrow[cs_id]"
      assert_select "input#csrow_cs_amount", :name => "csrow[cs_amount]"
    end
  end
end
