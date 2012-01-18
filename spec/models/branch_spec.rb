require 'spec_helper'

describe Branch do

  describe '.company' do
    before do
      @company = FactoryGirl.create(:company)
      restaurant = FactoryGirl.create(:restaurant, company: @company)
      @branch = FactoryGirl.create(:branch, restaurant: restaurant)
    end

    it 'should return its company' do
      @branch.company.should eq @company
    end
  end

  describe '.setting' do
    before do
      @setting = FactoryGirl.create(:setting)
      company = FactoryGirl.create(:company, :setting => @setting)
      restaurant = FactoryGirl.create(:restaurant, :company => company)
      @branch = FactoryGirl.create(:branch, :restaurant => restaurant)
    end

    it 'should return a setting' do
      @branch.setting.should eq @setting
    end
  end

  context 'Validation' do
    before do
      @branch = Branch.new
    end

    it 'should be invalid without location' do
      @branch.should have(1).error_on :location
    end

    it 'should be invalid without a restaurant_id' do
      @branch.should have(1).error_on :restaurant_id
    end
  end

  context 'Association' do
    it { should belong_to :restaurant }
  end
end
