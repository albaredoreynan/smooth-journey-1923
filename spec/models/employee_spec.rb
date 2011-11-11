require 'spec_helper'

describe Employee do

  it 'should return full_name' do
    employee = Employee.create!( :first_name => 'Juan', :last_name => 'dela Cruz' )
    employee.full_name.should eq 'Juan dela Cruz'
  end

  context 'Validation' do
    before do
      @employee = Employee.new
    end
    it 'should be invalid without first_name' do
      @employee.should have(1).error_on :first_name
    end

    it 'should be invalid without last name' do
      @employee.should have(1).error_on :last_name
    end
  end

  context 'Association' do
    it { should belong_to :branch }
    it { should belong_to :job }
    it { should belong_to :department }
  end

end
