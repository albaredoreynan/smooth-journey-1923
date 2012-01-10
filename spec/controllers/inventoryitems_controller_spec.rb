require 'spec_helper'

describe InventoryitemsController do
  context 'as admin' do
    login_admin

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

    context 'GET #index' do
      before do
        @item = FactoryGirl.create(:item, :name => "Poor Man's Shield", :branch => @current_user.branches.first)
        FactoryGirl.create(:item, :name => "Soul Ring")
        get 'index'
      end

      it 'should load all items within a branch' do
        assigns[:items].should eq [@item]
      end
    end

    context 'GET #new' do
      it 'should set a branch' do
        get 'new'
        assigns[:item].branch_id.should eq @current_branch.id
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
        post 'create', :item => FactoryGirl.attributes_for(:item, :name => 'XXX')
        item = Item.find_by_name('XXX')
        item.branch.should eq @current_branch
      end
    end

    context 'PUT #update' do
      it 'should not update branch_id' do
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
