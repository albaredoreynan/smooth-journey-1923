require 'spec_helper'

describe "employees/new.html.erb" do
  before(:each) do
    assign(:employee, stub_model(Employee,
      :employee_firstName => "MyString",
      :employee_lastName => "MyString",
      :branch_id => 1,
      :job_id => 1,
      :department_id => 1,
      :employee_age => 1,
      :employee_contactNumber => "MyString",
      :employee_sss => "MyString",
      :employee_tin => "MyString",
      :employee_address => "MyText"
    ).as_new_record)
  end

  it "renders new employee form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => employees_path, :method => "post" do
      assert_select "input#employee_employee_firstName", :name => "employee[employee_firstName]"
      assert_select "input#employee_employee_lastName", :name => "employee[employee_lastName]"
      assert_select "input#employee_branch_id", :name => "employee[branch_id]"
      assert_select "input#employee_job_id", :name => "employee[job_id]"
      assert_select "input#employee_department_id", :name => "employee[department_id]"
      assert_select "input#employee_employee_age", :name => "employee[employee_age]"
      assert_select "input#employee_employee_contactNumber", :name => "employee[employee_contactNumber]"
      assert_select "input#employee_employee_sss", :name => "employee[employee_sss]"
      assert_select "input#employee_employee_tin", :name => "employee[employee_tin]"
      assert_select "textarea#employee_employee_address", :name => "employee[employee_address]"
    end
  end
end
