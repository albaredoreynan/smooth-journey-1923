require 'spec_helper'

describe "ssrows/show.html.erb" do
  before(:each) do
    @ssrow = assign(:ssrow, stub_model(Ssrow,
      :st_id => 1,
      :ss_amount => 1.5
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
