require 'spec_helper'

describe SubcategoriesController do
  include Devise::TestHelpers

  before do
    @user = User.create!(:email => 'test@appsource.com', :password => 'password')
    sign_in @user
  end

  context 'GET #index' do
    before do
      @subcategory = FactoryGirl.create(:subcategory)
      get 'index'
    end

    it 'should load all subcategories' do
      assigns[:subcategories].should eq [@subcategory]
    end
  end

  context 'POST #create' do
    before do
      @post_params = { subcategory: { name: 'Subcategory B', category_id: 1 } }
    end

    it 'should redirect to #index' do
      post 'create', @post_params
      response.should redirect_to subcategories_path
    end

    it 'should save a subcategory' do
      lambda {
        post 'create', @post_params
      }.should change(Subcategory, :count).by 1
    end
  end
end
