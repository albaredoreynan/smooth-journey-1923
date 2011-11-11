require 'spec_helper'

describe "branches/show.html.erb" do
  before(:each) do
    @branch = assign(:branch, stub_model(Branch,
      :branch_location => "MyText",
      :user_id => 1,
      :branch_contactNumber => "Branch Contact Number"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Branch Contact Number/)
  end
end
