require 'spec_helper'

describe SaleCategoriesController do
  context 'as client' do
    login_client

    before do
      @restaurant = FactoryGirl.create(:restaurant, :company => @current_company)
    end

    context 'GET #index' do
      it 'should load sale categories within the company' do
        sale_category = FactoryGirl.create(:sale_category, :restaurant => @restaurant)
        FactoryGirl.create(:sale_category) # other sale category
        get 'index'
        assigns[:sale_categories].should eq [ sale_category ]
      end
    end

    context 'GET #new' do
      it 'should assign a sale category' do
        get 'new'
        assigns[:sale_category].should be_instance_of SaleCategory
      end
    end

    context 'POST #create' do
      it 'should create a sale category' do
        post_params = { :name => 'blah', :restaurant_id => @restaurant.id }
        lambda {
          post 'create', :sale_category => post_params
        }.should change(SaleCategory, :count).by(1)
      end
    end

    context 'GET #edit' do
      it 'should load sale category' do
        sale_category = FactoryGirl.create(:sale_category, :restaurant => @restaurant)
        get 'edit', :id => sale_category.id
        assigns[:sale_category].should eq sale_category
      end

      it 'should NOT be able to edit others sale category' do
        sale_category = FactoryGirl.create(:sale_category)
        get 'edit', :id => sale_category.id
        response.should_not be_successful
      end
    end

    context 'PUT #update' do
      it 'should be able to update sale category' do
        sale_category = FactoryGirl.create(:sale_category, :restaurant => @restaurant)
        put_params = { :name => 'blah' }
        lambda {
          put 'update', :id => sale_category.id, :sale_category => put_params
        }.should change{sale_category.reload.name}
      end

      it 'should NOT be able to update others sale category' do
        sale_category = FactoryGirl.create(:sale_category)
        put_params = { :name => 'blah' }
        lambda {
          put 'update', :id => sale_category.id, :sale_category => put_params
        }.should_not change{sale_category.reload.name}
      end
    end

    context 'DELETE #destroy' do
      it 'should be able to destroy sale category' do
        sale_category = FactoryGirl.create(:sale_category, :restaurant => @restaurant)
        lambda {
          delete 'destroy', :id => sale_category.id
        }.should change(SaleCategory, :count)
      end

      it 'shoul NOT be able to delete others sale category' do
        sale_category = FactoryGirl.create(:sale_category)
        lambda {
          delete 'destroy', :id => sale_category.id
        }.should_not change(SaleCategory, :count)
      end
    end
  end
end
