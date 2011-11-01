require 'spec_helper'

describe "conversions/new.html.erb" do
  before(:each) do
    assign(:conversion, stub_model(Conversion,
      :b_unit => "MyText",
      :s_unit => "MyText",
      :conversionNumber => 1.5
    ).as_new_record)
  end

  it "renders new conversion form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => conversions_path, :method => "post" do
      assert_select "textarea#conversion_b_unit", :name => "conversion[b_unit]"
      assert_select "textarea#conversion_s_unit", :name => "conversion[s_unit]"
      assert_select "input#conversion_conversionNumber", :name => "conversion[conversionNumber]"
    end
  end
end
