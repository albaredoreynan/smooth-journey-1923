require 'spec_helper'

describe "csrows/show.html.erb" do
  before(:each) do
    @csrow = assign(:csrow, stub_model(Csrow,
      :cs_id => 1,
      :cs_amount => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/1.5/)
  end
end
