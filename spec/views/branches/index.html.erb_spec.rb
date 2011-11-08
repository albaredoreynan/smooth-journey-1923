require 'spec_helper'

describe "branches/index.html.erb" do
  before(:each) do
    assign(:branches, [
      stub_model(Branch,
        :branch_location => "MyText",
        :user_id => 1,
        :branch_contactNumber => "Branch Contact Number"
      ),
      stub_model(Branch,
        :branch_location => "MyText",
        :user_id => 1,
        :branch_contactNumber => "Branch Contact Number"
      )
    ])
  end

  it "renders a list of branches" do
    pending
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Branch Contact Number".to_s, :count => 2
  end
end
