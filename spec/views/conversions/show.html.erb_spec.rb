require 'spec_helper'

describe "conversions/show.html.erb" do
  before(:each) do
    @conversion = assign(:conversion, stub_model(Conversion,
      :b_unit => "MyText",
      :s_unit => "MyText",
      :conversionNumber => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/1.5/)
  end
end
