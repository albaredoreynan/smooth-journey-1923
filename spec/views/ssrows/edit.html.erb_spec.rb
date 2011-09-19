require 'spec_helper'

describe "ssrows/edit.html.erb" do
  before(:each) do
    @ssrow = assign(:ssrow, stub_model(Ssrow,
      :new_record? => false,
      :st_id => 1,
      :ss_amount => 1.5
    ))
  end

  it "renders the edit ssrow form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => ssrow_path(@ssrow), :method => "post" do
      assert_select "input#ssrow_st_id", :name => "ssrow[st_id]"
      assert_select "input#ssrow_ss_amount", :name => "ssrow[ss_amount]"
    end
  end
end
