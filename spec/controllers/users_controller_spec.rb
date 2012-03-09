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

  context 'as client user' do
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

    describe 'GET #new' do
      it 'should have instance of User' do
        get 'new'
        assigns[:user].should be_instance_of User
      end

      it 'shoul be a new record' do
        get 'new'
        assigns[:user].should be_new_record
      end
    end

    describe 'POST #create' do
      before do
        @branch = FactoryGirl.create(:branch)
        @post_params = { :username => 'test', :password => 'test123', :email => 'test@example.com', :role => 'branch', :branch_id => @branch.id }
      end

      it 'should save new user' do
        lambda {
          post 'create', :user => @post_params
        }.should change(User, :count).by(1)
      end

      it 'should assign role' do
        lambda {
          post 'create', :user => @post_params
        }.should change(Role, :count).by(1)
      end
    end
  end

  context 'as branch user' do
    login_branch

    before do
      @user = FactoryGirl.create(:user)
      FactoryGirl.create(:role, :user => @user, :name => 'branch', :branch => @current_branch)
    end

    describe 'GET #edit' do
      it 'should NOT allow here' do
        get 'edit', :id => @user.id
        response.should_not be_successful # it should redirect somewhere
      end
    end

    describe 'PUT #update' do
      it 'should NOT allow update other user info' do
        lambda {
          put 'update', :id => @user.id, :user => { :username => 'blah' }
        }.should_not change{@user.reload.username}
      end

      it 'should be able to update current users info' do
        lambda {
          put 'update', :id => @current_user.id, :user => { :email => 'test@xyz.com' }
        }.should change{@current_user.reload.email}
      end
    end
  end
end
