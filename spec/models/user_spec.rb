require 'spec_helper'

describe User do

  it { should have_many :roles }
  it { should have_many :branches }

  context 'Validation' do
    before do
      @user = User.new
    end

    it 'should be invalid without username' do
      @user.should have_at_least(1).error_on :username
    end

    it 'should have a unique username' do
      FactoryGirl.create(:user, :username => 'nan')
      @user.username = 'nan'
      @user.should have(1).error_on :username
    end

    it 'should be invalid without email' do
      @user.should have(1).error_on :email
    end

  end

  it 'should return true if admin user' do
    admin_user = FactoryGirl.create(:admin_user)
    admin_user.should be_admin
  end

  it 'should return true if branch user' do
    branch_user = FactoryGirl.create(:branch_user)
    branch_user.should be_branch
  end

  it 'should assign role after user has been created' do
    lambda {
      @user = User.create(FactoryGirl.attributes_for(:user).merge(:role => 'branch', :branch_id => 1))
    }.should change(Role, :count).by(1)

    role = Role.find_by_user_id(@user.id)
    role.name.should eq 'branch'
  end

  it 'should save role branch' do
    branch = FactoryGirl.create(:branch)
    @user = User.create(FactoryGirl.attributes_for(:user).merge(:role => 'branch', :branch_id => branch.id))

    role = Role.find_by_user_id(@user.id)
    role.branch.should eq branch
  end

  it 'should NOT create new role if already exists' do
    @user = User.create(FactoryGirl.attributes_for(:user).merge(:role => 'branch', :branch_id => 1))
    lambda {
      @user.save
    }.should_not change(Role, :count)
  end

  describe '.setting' do
    it 'should return branch setting' do
      branch_user = FactoryGirl.create(:branch_user)
      branch_user.settings.should eq Company::DEFAULT_SETTINGS
    end

    it 'should return client setting' do
      client_user = FactoryGirl.create(:client_user)
      client_user.should be_client
      client_user.settings.should eq Company::DEFAULT_SETTINGS
    end
  end

  describe '#filter_by_company' do
    it 'should return users from company' do
      FactoryGirl.create(:user) # other user
      company = FactoryGirl.create(:company)
      company_user = FactoryGirl.create(:user, :email => 'company_user@example.com')
      FactoryGirl.create(:role, :user => company_user, :company => company)

      results = User.filter_by_company(company.id)
      results.should eq [company_user]
    end
  end
end
