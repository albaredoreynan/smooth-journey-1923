require 'spec_helper'
require 'cancan/matchers'

describe InventoryitemsController do
  context 'as client admin' do
    login_client

    before do
      @restaurant = FactoryGirl.create(:restaurant, :company => @current_company)
    end

    context 'GET #index' do
      before do
        #@branch = FactoryGirl.create(:branch, :restaurant => @restaurant)
        @item = FactoryGirl.create(:item, :restaurant => @restaurant)
        FactoryGirl.create(:item)
      end

      it 'should load items' do
        get 'index'
        assigns[:items].should eq [@item]
      end
    end
  end

  context 'as branch manager' do
    login_branch

    before do
      @restaurant = @current_branch.restaurant
    end

    context 'GET #index' do
      before do
        @items = [
          FactoryGirl.create(:item, :restaurant => @current_branch.restaurant),
          FactoryGirl.create(:item, :restaurant => @current_branch.restaurant)]
        FactoryGirl.create(:item) # other item
        get 'index'
      end

      it 'should load all items within a restaurant' do
        assigns[:items].should eq [@items[0], @items[1]]
      end
    end

    context 'GET #new' do
      it 'should set a restaurant' do
        get 'new'
        assigns[:item].restaurant_id.should eq @current_branch.restaurant.id
      end
    end

    context 'GET #edit' do
      it 'should denied access when editing other item' do
        get 'edit', :id => FactoryGirl.create(:item).to_param
        response.should redirect_to root_url
      end
    end

    context 'POST #create' do
      it 'should set a restaurant' do
        post 'create', :item => FactoryGirl.attributes_for(:item, :name => 'XXX')
        item = Item.find_by_name('XXX')
        item.restaurant.should eq @restaurant
      end
    end

    context 'PUT #update' do
      it 'should NOT update restaurant_id' do
        @restaurant = FactoryGirl.create(:restaurant)

        put_params = { :branch_id => @restaurant.to_param }
        @item = FactoryGirl.create(:item, :restaurant => @restaurant)

        lambda {
          put 'update', :id => @item.to_param, :item => put_params
        }.should_not change{@item.reload.branch_id}
      end
    end
  end
end
