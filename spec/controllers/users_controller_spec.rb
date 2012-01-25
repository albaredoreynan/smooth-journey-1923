require 'spec_helper'

describe UsersController do
  describe 'as admin' do
    login_admin

    describe 'GET #index' do
      it 'should show all users except logged in user' do
        user = FactoryGirl.create(:user)
        get 'index'
        assigns[:users].should eq [ user ]
      end
    end
  end

  describe 'as client user' do
    login_client

    describe 'GET #index' do
      it 'should only show all user within the company' do
        user = FactoryGirl.create(:user)
        FactoryGirl.create(:role, :user => user, :company => @current_company)
        FactoryGirl.create(:user) # other user
        get 'index'
        assigns[:users].should eq [ user ]
      end
    end
  end
end
