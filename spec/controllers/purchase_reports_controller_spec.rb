require 'spec_helper'

describe Reports::PurchaseReportsController do
  login_admin

  context 'as admin' do
    before do
      @item = FactoryGirl.create(:item, :subcategory => FactoryGirl.create(:subcategory, :name => 'SubA'))
    end

    it 'should load all purchase items from beginning of the month as default' do
      purchase_items = [
        FactoryGirl.create(:purchase_item, item: @item, amount: 2, quantity: 1,
                           purchase: FactoryGirl.create(:purchase, purchase_date: 30.days.ago.to_date)),
        FactoryGirl.create(:purchase_item, item: @item, amount: 5, quantity: 1,
                           purchase: FactoryGirl.create(:purchase, purchase_date: Date.today.beginning_of_month)),
        FactoryGirl.create(:purchase_item, item: @item, amount: 6, quantity: 1,
                           purchase: FactoryGirl.create(:purchase, purchase_date: Date.today))
      ]

      get 'index'
      assigns[:purchase_items].should eq @item.subcategory => [purchase_items[1], purchase_items[2]]
    end
  end
end
