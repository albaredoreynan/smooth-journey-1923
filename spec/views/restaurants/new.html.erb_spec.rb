require 'spec_helper'

describe "restaurants/new.html.erb" do
  before(:each) do
    assign(:restaurant, stub_model(Restaurant,
      :store_id => 1,
      :restaurant_name => "MyString",
      :company_id => 1,
      :restaurant_description => "MyText",
      :currency_id => 1
    ).as_new_record)
  end

  it "renders new restaurant form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => restaurants_path, :method => "post" do
      assert_select "input#restaurant_store_id", :name => "restaurant[store_id]"
      assert_select "input#restaurant_restaurant_name", :name => "restaurant[restaurant_name]"
      assert_select "input#restaurant_company_id", :name => "restaurant[company_id]"
      assert_select "textarea#restaurant_restaurant_description", :name => "restaurant[restaurant_description]"
      assert_select "input#restaurant_currency_id", :name => "restaurant[currency_id]"
    end
  end
end
