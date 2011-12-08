require 'spec_helper'

describe InventoryitemsController do
  login_user

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
