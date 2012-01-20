require 'spec_helper'

describe Reports::PurchaseReportsController do
  login_admin

  context 'as admin' do
    before do
      @item = FactoryGirl.create(:item, :subcategory => FactoryGirl.create(:subcategory, :name => 'SubA'))
      supplier = FactoryGirl.create(:supplier, name: 'Supplier Y')
      @purchase_items = [
        FactoryGirl.create(:purchase_item, item: @item, amount: 5, quantity: 1,
                           purchase: FactoryGirl.create(:purchase, purchase_date: Date.today.beginning_of_month)),
        FactoryGirl.create(:purchase_item, item: @item, amount: 6, quantity: 1,
                           purchase: FactoryGirl.create(:purchase, purchase_date: Date.today, supplier: supplier))
      ]
    end

    it 'should load all purchase items from beginning of the month as default' do
      FactoryGirl.create(:purchase_item, item: @item, amount: 2, quantity: 1,
                          purchase: FactoryGirl.create(:purchase, purchase_date: 30.days.ago.to_date))
      get 'index'
      assigns[:purchase_items].should eq @item.subcategory => [@purchase_items[1], @purchase_items[0]]
    end

    it 'should not match' do
      predate = 5.years.ago.to_date
      get 'index', start_date: predate, end_date: predate + 1.day
      assigns[:purchase_items].should be_empty
    end

    it 'should search purchase items' do
      get 'index', supplier: 'Supplier Y'
      assigns[:purchase_items].should eq @item.subcategory => [@purchase_items[1]]
    end

    it 'should search by invoice number' do
      purchase_with_invoice = FactoryGirl.create(:purchase_item, item: @item, purchase: FactoryGirl.create(:purchase, invoice_number: '9090'))
      get 'index', invoice_number: '9090'
      assigns[:purchase_items].should eq @item.subcategory => [purchase_with_invoice]
    end
    
    it 'should search by subcategory' do
      item = FactoryGirl.create(:item, :subcategory => FactoryGirl.create(:subcategory, :name => 'SubX'))
      target_purchase = FactoryGirl.create(:purchase_item, :item => item)
      get 'index', subcategory: 'SubX'
      assigns[:purchase_items].should eq item.subcategory => [target_purchase]
    end
  end
end