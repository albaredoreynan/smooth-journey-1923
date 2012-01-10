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

  it 'should create a role' do
    pending
    user = FactoryGirl.build(:user)
    user.role = 'admin'
    user.save
    user.reload.should be_admin
  end
end
