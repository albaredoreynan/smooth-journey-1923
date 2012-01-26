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
  end
end
