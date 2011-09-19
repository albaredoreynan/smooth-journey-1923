require 'spec_helper'

describe "companies/edit.html.erb" do
  before(:each) do
    @company = assign(:company, stub_model(Company,
      :new_record? => false,
      :company_name => "MyString",
      :company_address => "MyText",
      :company_number => "MyString"
    ))
  end

  it "renders the edit company form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => company_path(@company), :method => "post" do
      assert_select "input#company_company_name", :name => "company[company_name]"
      assert_select "textarea#company_company_address", :name => "company[company_address]"
      assert_select "input#company_company_number", :name => "company[company_number]"
    end
  end
end
