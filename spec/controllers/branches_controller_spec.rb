require 'spec_helper'

describe BranchesController do
  login_user

  context 'GET #index' do
    before do
      @branch = FactoryGirl.create(:branch)
      get 'index'
    end

    it 'should load all branches' do
      assigns[:branches].should eq [@branch]
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
