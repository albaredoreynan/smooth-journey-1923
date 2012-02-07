require 'spec_helper'

describe BranchesController do
  context 'as admin' do
    login_admin

    context 'GET #index' do
      before do
        @branch = FactoryGirl.create(:branch)
        get 'index'
      end

      it 'should load all branches' do
        assigns[:branches].should eq Branch.all
      end
    end

    context 'POST #create' do
      before do
        @post_params = { branch: { location: 'Makati', restaurant_id: 1 } }
      end

      it 'should redirect to #index' do
        post 'create', @post_params
        response.should redirect_to branches_path
      end

      it 'should save a branch' do
        lambda {
          post 'create', @post_params
        }.should change(Branch, :count).by 1
      end
    end
  end

  context 'as branch manager' do
    login_branch

    context 'GET #index' do
      before do
        FactoryGirl.create(:branch, :location => 'Other Branch')
        get 'index'
      end

      it 'should load branch that belongs to the user' do
        assigns[:branches].should eq @current_user.branches.all
      end
    end

    context 'DELETE #destroy' do
      it 'should not be able to delete a branch' do
        delete 'destroy', :id => @current_user.branches.first.to_param
        response.should redirect_to root_url
      end
    end
  end
end
