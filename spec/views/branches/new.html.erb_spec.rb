require 'spec_helper'

describe "branches/new.html.erb" do
  before(:each) do
    assign(:branch, stub_model(Branch,
      :branch_location => "MyText",
      :user_id => 1,
      :branch_contactNumber => "MyString"
    ).as_new_record)
  end

  it "renders new branch form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => branches_path, :method => "post" do
      assert_select "textarea#branch_branch_location", :name => "branch[branch_location]"
      assert_select "input#branch_user_id", :name => "branch[user_id]"
      assert_select "input#branch_branch_contactNumber", :name => "branch[branch_contactNumber]"
    end
  end
end
