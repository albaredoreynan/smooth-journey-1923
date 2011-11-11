require 'spec_helper'

describe "subcategories/show.html.erb" do
  before(:each) do
    @subcategory = assign(:subcategory, stub_model(Subcategory,
      :subcategory_name => "Subcategory Name",
      :subcategory_description => "MyText",
      :category_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Subcategory Name/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
