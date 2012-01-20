require 'spec_helper'
require 'cancan/matchers'

describe SubcategoriesController do
  context 'as admin' do
    login_admin

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

  context 'as client user' do
    login_client

    before do
      @restaurant = FactoryGirl.create(:restaurant, :company => @current_company)
      @category = FactoryGirl.create(:category, :restaurant => @restaurant)
      @ability = Ability.new(@current_user)
    end

    context 'GET #index' do
      before do
        @subcategory = FactoryGirl.create(:subcategory, :category => @category)
      end

      it 'should only show subcategory from its company' do
        FactoryGirl.create(:subcategory)
        get 'index'
        assigns[:subcategories].should eq [ @subcategory ]
      end
    end

    context 'POST #create' do
      before do
        @post_params = { :name => 'Sub Z', :category_id => @category.to_param }
      end

      it 'should be able to add a subcategory' do
        lambda {
          post 'create', :subcategory => @post_params
        }.should change(Subcategory, :count).by(1)
      end

      it 'should only allow to add subcategory of his own' do
        post 'create', :subcategory => @post_params
        subcategory = Subcategory.find_by_name('Sub Z')
        subcategory.category.should eq @category
      end
    end
  end
end
