require 'spec_helper'

describe "currencies/show.html.haml" do
  before(:each) do
    @currency = assign(:currency, stub_model(Currency,
      :currency => "Currency",
      :symbol => "Symbol"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Currency/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Symbol/)
  end
end
