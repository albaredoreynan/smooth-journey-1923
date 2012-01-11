require 'spec_helper'

describe CategoriesController do
  context 'as admin' do
    login_admin
  
    context 'GET #index' do
      before do
        @category = FactoryGirl.create(:category)
        get 'index'
      end
  
      it 'should load all category' do
        assigns[:categories].should eq [@category]
      end
    end
  
    context 'POST #create' do
      before do
        @post_params = { category: { name: 'Category A' } }
      end
  
      it 'should redirect to #index' do
        post 'create', @post_params
        response.should redirect_to categories_path
      end
  
      it 'should save a category' do
        lambda {
          post 'create', @post_params
        }.should change(Category, :count).by 1
      end
    end
  end
  
  context 'as branch manager' do
    login_branch
    
    context 'GET #index' do
      it 'should only show categories from branch restaurant' do
        category = FactoryGirl.create(:category, :restaurant => @current_branch.restaurant)
        FactoryGirl.create(:category, :name => 'Other Category')
        get 'index'
        assigns[:categories].should eq [category]
      end
    end
  end
end
