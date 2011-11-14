require 'spec_helper'

describe "currencies/new.html.haml" do
  before(:each) do
    assign(:currency, stub_model(Currency,
      :currency => "MyString",
      :symbol => "MyString"
    ).as_new_record)
  end

  it "renders new currency form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => currencies_path, :method => "post" do
      assert_select "input#currency_currency", :name => "currency[currency]"
      assert_select "input#currency_symbol", :name => "currency[symbol]"
    end
  end
end
