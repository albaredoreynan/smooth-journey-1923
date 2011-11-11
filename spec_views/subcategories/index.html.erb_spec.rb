require 'spec_helper'

describe "subcategories/index.html.erb" do
  before(:each) do
    assign(:subcategories, [
      stub_model(Subcategory,
        :subcategory_name => "Subcategory Name",
        :subcategory_description => "MyText",
        :category_id => 1
      ),
      stub_model(Subcategory,
        :subcategory_name => "Subcategory Name",
        :subcategory_description => "MyText",
        :category_id => 1
      )
    ])
  end

  it "renders a list of subcategories" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Subcategory Name".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
