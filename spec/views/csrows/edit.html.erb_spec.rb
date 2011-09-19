require 'spec_helper'

describe "csrows/edit.html.erb" do
  before(:each) do
    @csrow = assign(:csrow, stub_model(Csrow,
      :new_record? => false,
      :cs_id => 1,
      :cs_amount => 1.5
    ))
  end

  it "renders the edit csrow form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => csrow_path(@csrow), :method => "post" do
      assert_select "input#csrow_cs_id", :name => "csrow[cs_id]"
      assert_select "input#csrow_cs_amount", :name => "csrow[cs_amount]"
    end
  end
end
