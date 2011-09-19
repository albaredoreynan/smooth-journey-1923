require 'spec_helper'

describe "ssrows/index.html.erb" do
  before(:each) do
    assign(:ssrows, [
      stub_model(Ssrow,
        :st_id => 1,
        :ss_amount => 1.5
      ),
      stub_model(Ssrow,
        :st_id => 1,
        :ss_amount => 1.5
      )
    ])
  end

  it "renders a list of ssrows" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end
