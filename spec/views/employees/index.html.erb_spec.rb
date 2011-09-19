require 'spec_helper'

describe "employees/index.html.erb" do
  before(:each) do
    assign(:employees, [
      stub_model(Employee,
        :employee_firstName => "Employee First Name",
        :employee_lastName => "Employee Last Name",
        :branch_id => 1,
        :job_id => 1,
        :department_id => 1,
        :employee_age => 1,
        :employee_contactNumber => "Employee Contact Number",
        :employee_sss => "Employee Sss",
        :employee_tin => "Employee Tin",
        :employee_address => "MyText"
      ),
      stub_model(Employee,
        :employee_firstName => "Employee First Name",
        :employee_lastName => "Employee Last Name",
        :branch_id => 1,
        :job_id => 1,
        :department_id => 1,
        :employee_age => 1,
        :employee_contactNumber => "Employee Contact Number",
        :employee_sss => "Employee Sss",
        :employee_tin => "Employee Tin",
        :employee_address => "MyText"
      )
    ])
  end

  it "renders a list of employees" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Employee First Name".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Employee Last Name".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Employee Contact Number".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Employee Sss".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Employee Tin".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
