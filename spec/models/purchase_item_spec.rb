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
      @purchase_row.should have(1).error_on :amount
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

  describe '#unit_name' do
    it 'should return a unit_name' do
      @unit = FactoryGirl.create(:unit, :name => 'kg')
      @purchase_item = FactoryGirl.create(:purchase_item, :unit => @unit)
      @purchase_item.unit_name.should eq 'kg'
    end
  end

  context 'Search' do
    it 'should search by purchase_date' do
      start_date = 5.days.ago.to_date
      end_date = Date.today
      item = FactoryGirl.create(:item)
      purchase_items = [
        FactoryGirl.create(:purchase_item, item: item,
                            purchase: FactoryGirl.create(:purchase, purchase_date: start_date)),
        FactoryGirl.create(:purchase_item, item: item,
                            purchase: FactoryGirl.create(:purchase, purchase_date: end_date))
      ]
      purchase_item_result = PurchaseItem.search_by_date(start_date, end_date)
      purchase_item_result.should eq purchase_items
    end
  end
end
