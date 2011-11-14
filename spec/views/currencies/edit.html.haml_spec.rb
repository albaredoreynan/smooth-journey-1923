require 'spec_helper'

describe "currencies/edit.html.haml" do
  before(:each) do
    @currency = assign(:currency, stub_model(Currency,
      :currency => "MyString",
      :symbol => "MyString"
    ))
  end

  it "renders the edit currency form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => currencies_path(@currency), :method => "post" do
      assert_select "input#currency_currency", :name => "currency[currency]"
      assert_select "input#currency_symbol", :name => "currency[symbol]"
    end
  end
end
