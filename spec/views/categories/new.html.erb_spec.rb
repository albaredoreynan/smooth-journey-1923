require 'spec_helper'

describe "categories/new.html.erb" do
  before(:each) do
    assign(:category, stub_model(Category,
      :category_name => "MyString",
      :category_description => "MyText",
      :restaurant_category_id => 1
    ).as_new_record)
  end

  it "renders new category form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => categories_path, :method => "post" do
      assert_select "input#category_category_name", :name => "category[category_name]"
      assert_select "textarea#category_category_description", :name => "category[category_description]"
      assert_select "input#category_restaurant_category_id", :name => "category[restaurant_category_id]"
    end
  end
end
