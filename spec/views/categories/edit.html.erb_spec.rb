require 'spec_helper'

describe "categories/edit.html.erb" do
  before(:each) do
    @category = assign(:category, stub_model(Category,
      :new_record? => false,
      :category_name => "MyString",
      :category_description => "MyText",
      :restaurant_category_id => 1
    ))
  end

  it "renders the edit category form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => category_path(@category), :method => "post" do
      assert_select "input#category_category_name", :name => "category[category_name]"
      assert_select "textarea#category_category_description", :name => "category[category_description]"
      assert_select "input#category_restaurant_category_id", :name => "category[restaurant_category_id]"
    end
  end
end
