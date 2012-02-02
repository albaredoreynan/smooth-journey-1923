require 'spec_helper'

describe Company do

  it 'should save company given a valid attributes' do
    Company.create!({:name => 'Company A'})
  end

  context 'Validation' do
    before do
      @company = Company.new
    end

    it 'should have company name' do
      @company.should have(1).error_on :name
    end
  end

  context 'Association' do
    it { should have_many :restaurants }
  end

  describe '.settings' do
    before do
      @company = FactoryGirl.build(:company)
      @settings = { :enable_lock_module => true, :lock_module_in => 5 }
    end

    it 'should save settings' do
      @company.settings = @settings
      @company.save
      @company.reload.settings.should eq @settings
    end

    it 'should be default to empty hash' do
      company = Company.new
      company.settings.should eq ({ :enable_lock_module => false, :lock_module_in => 0 })
    end

    it 'should save the correct data type' do
      # pass value by string on settings field and it should save as boolean and integer
      company = Company.create({:settings => { :enable_lock_module => '1', :lock_module_in => '23' }})
      company.settings[:enable_lock_module].should be_kind_of TrueClass
      company.settings[:lock_module_in].should be_kind_of Integer
    end
  end
end
