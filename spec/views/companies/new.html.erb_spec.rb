require 'spec_helper'

describe "companies/new.html.erb" do
  before(:each) do
    assign(:company, stub_model(Company,
      :company_name => "MyString",
      :company_address => "MyText",
      :company_number => "MyString"
    ).as_new_record)
  end

  it "renders new company form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => companies_path, :method => "post" do
      assert_select "input#company_company_name", :name => "company[company_name]"
      assert_select "textarea#company_company_address", :name => "company[company_address]"
      assert_select "input#company_company_number", :name => "company[company_number]"
    end
  end
end
