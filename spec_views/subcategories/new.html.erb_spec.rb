require 'spec_helper'

describe "subcategories/new.html.erb" do
  before(:each) do
    assign(:subcategory, stub_model(Subcategory,
      :subcategory_name => "MyString",
      :subcategory_description => "MyText",
      :category_id => 1
    ).as_new_record)
  end

  it "renders new subcategory form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => subcategories_path, :method => "post" do
      assert_select "input#subcategory_subcategory_name", :name => "subcategory[subcategory_name]"
      assert_select "textarea#subcategory_subcategory_description", :name => "subcategory[subcategory_description]"
      assert_select "input#subcategory_category_id", :name => "subcategory[category_id]"
    end
  end
end
