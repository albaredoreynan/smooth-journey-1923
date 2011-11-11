require 'spec_helper'

describe "subcategories/edit.html.erb" do
  before(:each) do
    @subcategory = assign(:subcategory, stub_model(Subcategory,
      :new_record? => false,
      :subcategory_name => "MyString",
      :subcategory_description => "MyText",
      :category_id => 1
    ))
  end

  it "renders the edit subcategory form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => subcategory_path(@subcategory), :method => "post" do
      assert_select "input#subcategory_subcategory_name", :name => "subcategory[subcategory_name]"
      assert_select "textarea#subcategory_subcategory_description", :name => "subcategory[subcategory_description]"
      assert_select "input#subcategory_category_id", :name => "subcategory[category_id]"
    end
  end
end
