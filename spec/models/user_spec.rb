require 'spec_helper'

describe User do

  it { should have_many :roles }
  it { should have_many :branches }

  it 'should return true if admin user' do
    admin_user = FactoryGirl.create(:admin_user)
    admin_user.should be_admin
  end

  it 'should return true if branch user' do
    branch_user = FactoryGirl.create(:branch_user)
    branch_user.should be_branch
  end

  describe '.setting' do
    it 'should return branch setting' do
      branch_user = FactoryGirl.create(:branch_user)
      branch_user.setting.should eq branch_user.branches.first.setting
    end

    it 'should return client setting' do
      client_user = FactoryGirl.create(:client_user)
      setting = Setting.find_by_company_id(client_user.companies.first.id)
      setting.should_not be_nil
      client_user.should be_client
      client_user.setting.should eq setting
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
