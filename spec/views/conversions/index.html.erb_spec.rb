require 'spec_helper'

describe "conversions/index.html.erb" do
  before(:each) do
    assign(:conversions, [
      stub_model(Conversion,
        :b_unit => "MyText",
        :s_unit => "MyText",
        :conversionNumber => 1.5
      ),
      stub_model(Conversion,
        :b_unit => "MyText",
        :s_unit => "MyText",
        :conversionNumber => 1.5
      )
    ])
  end

  it "renders a list of conversions" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end
