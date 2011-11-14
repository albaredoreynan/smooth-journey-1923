require 'spec_helper'

describe "currencies/index.html.haml" do
  before(:each) do
    assign(:currencies, [
      stub_model(Currency,
        :currency => "Currency",
        :symbol => "Symbol"
      ),
      stub_model(Currency,
        :currency => "Currency",
        :symbol => "Symbol"
      )
    ])
  end

  it "renders a list of currencies" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Currency".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Symbol".to_s, :count => 2
  end
end
