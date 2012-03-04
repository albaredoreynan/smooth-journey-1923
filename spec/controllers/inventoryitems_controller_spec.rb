require 'spec_helper'
require 'cancan/matchers'

describe InventoryitemsController do
  context 'as admin' do
    login_admin

    context 'POST #create' do
      before do
        @post_params = { :name => 'Bracer', :item_count => 90 }
      end

      it 'should set initial item count on an item' do
        pending
        post :create, :item => @post_params
        item = Item.where(:name => 'Bracer').first
        item.item_count.should eq 90
      end
    end

    context 'PUT #update' do
      it 'should update item_count' do
        pending
        item_count = FactoryGirl.create(:item_count, :stock_count => 100)
        item = item_count.item
        put 'update', :id => item.id, :item => {:item_count => 50}
        item.reload
        item.item_count.should eq 50
      end
    end
  end

  context 'as client admin' do
    login_client

    context 'GET #index' do
      before do
        @restaurant = FactoryGirl.create(:restaurant, :company => @current_company)
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
      it 'should set a branch' do
        pending 'for delete'
        get 'new'
        assigns[:item].branch_id.should eq @current_branch.id
      end

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
      it 'should set a branch' do
        pending
        post 'create', :item => FactoryGirl.attributes_for(:item, :name => 'XXX')
        item = Item.find_by_name('XXX')
        item.branch.should eq @current_branch
      end
    end

    context 'PUT #update' do
      it 'should not update branch_id' do
        pending
        @branch = FactoryGirl.create(:branch)
        put_params = {:branch_id => @branch.to_param}
        @item = FactoryGirl.create(:item, :branch => @current_branch)
        lambda {
          put 'update', :id => @item.to_param, :item => put_params
        }.should_not change{@item.reload.branch_id}
      end
    end
  end
end
