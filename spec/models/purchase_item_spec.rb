require 'spec_helper'

describe PurchaseItem do

  context 'Validation' do
    before do
      @purchase_row = PurchaseItem.new
    end

    it 'should be invalid without item id' do
      @purchase_row.should have(1).error_on :item_id
    end

    it 'should be invalid without amount' do
      @purchase_row.should have_at_least(1).error_on :amount
    end

    it 'should be invalid without quantity' do
      @purchase_row.should have_at_least(1).error_on :quantity
    end
  end

  describe '#net_amount' do
    it 'should calculate net_amount when vat type is inclusive' do
      purchase_row = FactoryGirl.create(:purchase_item,
                                        :amount => 5,
                                        :purchase => FactoryGirl.create(:purchase, :vat_type => 'VAT-Inclusive'))
      purchase_row.net_amount.should eq 4.46
    end

    it 'should calculate net_amount when vat type is exclusive' do
      purchase_row = FactoryGirl.create(:purchase_item,
                                        :amount => 5,
                                        :purchase => FactoryGirl.create(:purchase, :vat_type => 'VAT-Exclusive'))
      purchase_row.net_amount.should eq 5
    end

    it 'should calculate net_amount when vat type is exempted' do
      purchase_row = FactoryGirl.create(:purchase_item,
                                        :amount => 5,
                                        :purchase => FactoryGirl.create(:purchase, :vat_type => 'VAT-Exempted'))
      purchase_row.net_amount.should eq 5
    end
  end

  describe '#purchase_amount' do
    it 'should calculate purchase_amount when vat_type is exclusive' do
      purchase_item = FactoryGirl.create(:purchase_item,
                                        :amount => 1,
                                        :purchase => FactoryGirl.create(:purchase, :vat_type => 'VAT-Exclusive'))
      purchase_item.purchase_amount.should eq 1.12
    end

    it' should calculate purchase_amount when vat_type is inclusive' do
      purchase_item = FactoryGirl.create(:purchase_item,
                                        :amount => 1,
                                        :purchase => FactoryGirl.create(:purchase, :vat_type => 'VAT-Inclusive'))
      purchase_item.purchase_amount.should eq 1
    end

    it 'should calculate purchase_amount when vat_type is exempted' do
      purchase_item = FactoryGirl.create(:purchase_item,
                                        :amount => 1,
                                        :purchase => FactoryGirl.create(:purchase, :vat_type => 'VAT-Exempted'))
      purchase_item.purchase_amount.should eq 1
    end
  end

  describe '#quantity' do
    before do
      @unit = FactoryGirl.create(:unit)
      @purchase_item = FactoryGirl.create(:purchase_item, :quantity => 10, :unit => @unit)
    end

    it 'should create a Quantity object on purchase_item' do
      @purchase_item.qty.should be_instance_of Quantity
      @purchase_item.qty.value.should eq 10
    end

    it 'should create a Unit object on Quantity' do
      @purchase_item.qty.unit.should be_instance_of Unit
    end

    it 'should create a Quantity given a valid attributes' do
      @purchase_item.qty.value.should eq 10
      @purchase_item.qty.unit.symbol.should eq @unit.symbol
    end
  end

  describe '#unit_cost' do
    before do
      @inch_unit = FactoryGirl.create(:unit, :symbol => 'in')
      @cm_unit = FactoryGirl.create(:unit, :symbol => 'cm')
      FactoryGirl.create(:conversion,
                         :bigger_unit => @inch_unit,
                         :smaller_unit => @cm_unit,
                         :conversion_factor => 2.54)
      @item = FactoryGirl.create(:item, :unit => @cm_unit)
      @purchase_item = FactoryGirl.create(:purchase_item,
                                          :amount => 5,
                                          :quantity => 2,
                                          :item => @item,
                                          :unit => @inch_unit)
    end

    it 'should calculate unit_cost without conversion' do
      @purchase_item.convert_unit = false
      @purchase_item.unit_cost.should eq 2.5
    end

    it 'should calculate unit_cost in inventory unit' do
      @purchase_item.convert_unit = true
      @purchase_item.unit_cost.should be_between(0.98, 0.985)
    end
  end

  describe '#item_name' do
    it 'should return an item_name' do
      @item = FactoryGirl.create(:item, :name => 'Circlet of Nobility')
      @purchase_item = FactoryGirl.create(:purchase_item, :item => @item)
      @purchase_item.item_name.should eq 'Circlet of Nobility'
    end
  end

  describe '#subcategory_name' do
    it 'should return a subcategory name' do
      @item = FactoryGirl.create(:item, :subcategory => FactoryGirl.create(:subcategory, name: 'SubA'))
      purchase_item  = FactoryGirl.create(:purchase_item, item: @item)
      purchase_item.subcategory_name.should eq 'SubA'
    end
  end

  describe '#unit_name' do
    it 'should return a unit_name' do
      @unit = FactoryGirl.create(:unit, :name => 'kg')
      @purchase_item = FactoryGirl.create(:purchase_item, :unit => @unit)
      @purchase_item.unit_name.should eq 'kg'
    end
  end

  context 'Search' do
    before do
      @start_date = 5.days.ago.to_date
      @end_date = Date.today
      @item = FactoryGirl.create(:item, name: 'Magic Wand')
      supplier = FactoryGirl.create(:supplier, name: 'Supplier X')
      @purchase_items = [
        FactoryGirl.create(:purchase_item, item: @item,
                            purchase: FactoryGirl.create(:purchase,
                                                         invoice_number: '9090',
                                                         purchase_date: @start_date,
                                                         supplier: supplier)),
        FactoryGirl.create(:purchase_item, item: @item,
                            purchase: FactoryGirl.create(:purchase, purchase_date: @end_date))
      ]
    end

    it 'should search by purchase_date' do
      # purchase that should not be included on search result
      FactoryGirl.create(:purchase_item, item: @item,
                          purchase: FactoryGirl.create(:purchase, purchase_date: 1.year.ago.to_date))
      search_results = PurchaseItem.search(start_date: @start_date, end_date: @end_date)
      search_results.should eq @purchase_items
    end

    it 'should search by supplier name' do
      search_results = PurchaseItem.search(supplier: 'Supplier X')
      search_results.should eq [@purchase_items[0]]
    end

    it 'should search by invoice number' do
      search_results = PurchaseItem.search(invoice_number: '9090')
      search_results.should eq [@purchase_items[0]]
    end

    it 'should search an item name' do
      FactoryGirl.create(:purchase_item, item: FactoryGirl.create(:item, name: 'other item'))
      search_results = PurchaseItem.search(item: 'Magic') # item name that starts with ..
      search_results.should eq [@purchase_items[1], @purchase_items[0]]
    end

    it 'should search with combined queries' do
      search_results = PurchaseItem.search(start_date: @start_date, end_date: @end_date, supplier: 'Supplier X')
      search_results.should eq [@purchase_items[0]]
    end
  end
end
