require 'spec_helper'

describe RestaurantsController do
  login_user

  context 'GET #index' do
    before do
      @restaurant = FactoryGirl.create(:restaurant)
      get 'index'
    end

    it 'should load all restaurants' do
      assigns[:restaurants].should eq [@restaurant]
    end
  end

  context 'POST #create' do
    before do
      @post_params = { restaurant: { store_id: '123', name: 'Restaurant X' } }
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
  end
end
