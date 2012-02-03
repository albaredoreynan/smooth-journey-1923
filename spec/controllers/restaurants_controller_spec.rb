require 'spec_helper'

describe RestaurantsController do
  context 'as client' do
    login_client

    context 'GET #index' do
      before do
        @restaurant = FactoryGirl.create(:restaurant, :company => @current_company)
      end

      it 'should load all restaurant that belongs to company' do
        get 'index'
        assigns[:restaurants].should eq @current_company.restaurants.all
      end
    end

    context 'POST #create' do
      before do
        @post_params = { restaurant: { name: 'Restaurant X' } }
      end

      it 'should redirect to #index' do
        post 'create', @post_params
        response.should redirect_to restaurants_path
      end

      it 'should save a restaurant' do
        lambda {
          post 'create', @post_params
        }.should change(Restaurant, :count).by 1
      end

      it 'should default company to clients company' do
        post 'create', @post_params
        restaurant = Restaurant.find_by_name('Restaurant X')
        restaurant.company.should eq @current_company
      end
    end

    context 'PUT #update' do
      it 'should not be able to update company' do
        other_company = FactoryGirl.create(:company)
        put_params = { :company_id => other_company.to_param }
        restaurant = FactoryGirl.create(:restaurant, :company => @current_company)
        lambda {
          put 'update', :id => restaurant.to_param, :restaurant => put_params
        }.should_not change{restaurant.reload.company_id}
      end
    end
  end
end
