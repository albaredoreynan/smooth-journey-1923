require 'spec_helper'

describe InventoryitemsController do
  context 'as user' do
    login_user

    context 'POST #create' do
      before do
        @post_params = { :name => 'Bracer', :item_count => 90 }
      end
      it 'should set initial item count on an item' do
        post :create, :item => @post_params
        item = Item.where(:name => 'Bracer').first
        item.item_count.should eq 90
      end
    end

    context 'PUT #update' do
      it 'should update item_count' do
        item_count = FactoryGirl.create(:item_count, :stock_count => 100)
        item = item_count.item
        put 'update', :id => item.id, :item => {:item_count => 50}
        item.reload
        item.item_count.should eq 50
      end
    end
  end

  context 'as branch manager' do
    login_branch

    context 'POST #index' do
      before do
        @item = FactoryGirl.create(:item, :name => "Poor Man's Shield", :branch => @current_user.branches.first)
        FactoryGirl.create(:item, :name => "Soul Ring")
        get 'index'
      end

      it 'should load all items within a branch' do
        assigns[:items].should eq [@item]
      end
    end
  end
end
