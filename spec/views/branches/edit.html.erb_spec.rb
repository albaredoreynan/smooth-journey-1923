require 'spec_helper'

describe "branches/edit.html.erb" do
  before(:each) do
    @branch = assign(:branch, stub_model(Branch,
      :new_record? => false,
      :branch_location => "MyText",
      :user_id => 1,
      :branch_contactNumber => "MyString"
    ))
  end

  it "renders the edit branch form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => branch_path(@branch), :method => "post" do
      assert_select "textarea#branch_branch_location", :name => "branch[branch_location]"
      assert_select "input#branch_user_id", :name => "branch[user_id]"
      assert_select "input#branch_branch_contactNumber", :name => "branch[branch_contactNumber]"
    end
  end
end
