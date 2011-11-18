require 'spec_helper'

describe EndcountsController do
  include Devise::TestHelpers

  before do
    @user = User.create!(:email => 'test@appsource.com', :password => 'password')
    sign_in @user
  end

  context 'GET #index' do
    it 'should load all endcounts' do
      @endcount = FactoryGirl.create(:endcount)
      get 'index'
      assigns[:endcounts].should eq [@endcount]
    end
  end

  context 'GET #new' do
    it 'should load all items' do
      pending 'Something weird happens here'
      @item = FactoryGirl.create(:item)
      get 'new'
      assigns[:endcount].item_counts.length.should eq 1
    end

    it 'should pre-loaded the beginning count' do
      @endcount = FactoryGirl.create(:endcount)
      @item = FactoryGirl.create(:item)
      @item2 = FactoryGirl.create(:item)
      # I inserted two item_counts to make sure that the last item will be
      # fetched regardless of date
      @endcount.item_counts.create ({
        :inventoryitem_id => @item.id,
        :beginning_count => 5,
        :end_count => 10,
        :created_at => 60.seconds.ago
      })
      @endcount.item_counts.create ({
        :inventoryitem_id => @item.id,
        :beginning_count => 10,
        :end_count => 12,
        :created_at => Time.now
      })
      get 'new'
      item_counts = assigns[:endcount].item_counts
      item_counts.first.beginning_count.should eq 12
      item_counts.first.inventoryitem_id.should eq @item.id
    end
  end
end
