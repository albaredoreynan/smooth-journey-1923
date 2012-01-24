require 'spec_helper'

describe Role do
  context 'Validation' do
    it 'should be invalid without name' do
      role = Role.new
      role.should have_at_least(1).error_on :name
    end

    it 'should have a valid role name' do
      Role::VALID_ROLES.each do |role|
        user = FactoryGirl.create(:user)
        role = Role.new(:name => role, :user => user)
        role.should be_valid
      end
    end

    it 'should be invalid without user_id' do
      role = Role.new
      role.should have(1).error_on :user_id
    end
  end

  context 'Association' do
    it { should belong_to :user }
    it { should belong_to :branch }
  end

  context '.set_company_id' do
    before do
      @company = FactoryGirl.create(:company)
      @restaurant = FactoryGirl.create(:restaurant, :company => @company )
      @branch = FactoryGirl.create(:branch, :restaurant => @restaurant)
      @user = FactoryGirl.create(:user)
    end
    it 'should automatically set company id from the branch' do
      role = Role.create(FactoryGirl.attributes_for(:role, :branch => @branch, :user => @user))
      role.reload.company_id.should eq @company.id
    end

    it 'should save even without branch' do
      role = Role.create(FactoryGirl.attributes_for(:role, :branch => nil, :user => @user))
      role.reload.company_id.should be_nil
    end
  end
end
