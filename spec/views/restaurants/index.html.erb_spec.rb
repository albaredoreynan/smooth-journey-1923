require 'spec_helper'

describe "restaurants/index.html.erb" do
  before(:each) do
    assign(:restaurants, [
      stub_model(Restaurant,
        :store_id => 1,
        :restaurant_name => "Restaurant Name",
        :company_id => 1,
        :restaurant_description => "MyText",
        :currency_id => 1
      ),
      stub_model(Restaurant,
        :store_id => 1,
        :restaurant_name => "Restaurant Name",
        :company_id => 1,
        :restaurant_description => "MyText",
        :currency_id => 1
      )
    ])
  end

  it "renders a list of restaurants" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Restaurant Name".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
