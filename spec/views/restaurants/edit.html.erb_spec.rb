require 'spec_helper'

describe "restaurants/edit.html.erb" do
  before(:each) do
    @restaurant = assign(:restaurant, stub_model(Restaurant,
      :new_record? => false,
      :store_id => 1,
      :restaurant_name => "MyString",
      :company_id => 1,
      :restaurant_description => "MyText",
      :currency_id => 1
    ))
  end

  it "renders the edit restaurant form" do
    pending 'fail'
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => restaurant_path(@restaurant), :method => "post" do
      assert_select "input#restaurant_store_id", :name => "restaurant[store_id]"
      assert_select "input#restaurant_restaurant_name", :name => "restaurant[restaurant_name]"
      assert_select "input#restaurant_company_id", :name => "restaurant[company_id]"
      assert_select "textarea#restaurant_restaurant_description", :name => "restaurant[restaurant_description]"
      assert_select "input#restaurant_currency_id", :name => "restaurant[currency_id]"
    end
  end
end
