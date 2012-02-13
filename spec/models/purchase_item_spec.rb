require 'spec_helper'

describe PurchaseItem do

  context 'Validation' do
    before do
      @purchase_row = PurchaseItem.new
      @purchase_row.item = FactoryGirl.create(:item)
    end

    it 'should be invalid without item id' do
      @purchase_row.item_id = nil
      @purchase_row.should have(1).error_on :item_id
    end

    it 'should be invalid without amount' do
      @purchase_row.should have_at_least(1).error_on :amount
    end

    it 'should be invalid without quantity' do
      @purchase_row.should have_at_least(1).error_on :quantity
    end

    it 'should be invalid without vat type' do
      @purchase_row.should have_at_least(1).error_on :vat_type
    end

    %w(VAT VAT-Ex Exclusive).each do |vat_type|
      it "should be invalid on unknown vat type (e.g. vat_type = #{vat_type})" do
        @purchase_row.vat_type = vat_type
        @purchase_row.should have(1).error_on :vat_type
      end
    end

    %w(VAT-Exclusive VAT-Inclusive VAT-Exempted).each do |vat_type|
      it 'should be valid on known vat type' do
        @purchase_row.vat_type = vat_type
        @purchase_row.should have(0).error_on :vat_type
      end
    end

    it 'should be invalid without unit id' do
      @purchase_row.should have_at_least(1).error_on :unit_id
    end
  end

  describe '.net_amount' do
    it 'should calculate net_amount when vat type is inclusive' do
      purchase_row = FactoryGirl.create(:purchase_item,
                                        :amount => 5,
                                        :vat_type => 'VAT-Inclusive')
      purchase_row.net_amount.should be_between(4.464, 4.465)
    end

    it 'should calculate net_amount when vat type is exclusive' do
      purchase_row = FactoryGirl.create(:purchase_item,
                                        :amount => 5,
                                        :vat_type => 'VAT-Exclusive')
      purchase_row.net_amount.should eq 5
    end

    it 'should calculate net_amount when vat type is exempted' do
      purchase_row = FactoryGirl.create(:purchase_item,
                                        :amount => 5,
                                        :vat_type => 'VAT-Exempted')
      purchase_row.net_amount.should eq 5
    end
  end

  describe '.purchase_amount' do
    it 'should calculate purchase_amount when vat_type is exclusive' do
      purchase_item = FactoryGirl.create(:purchase_item,
                                        :amount => 1,
                                        :vat_type => 'VAT-Exclusive')
      purchase_item.purchase_amount.should eq 1.12
    end

    it' should calculate purchase_amount when vat_type is inclusive' do
      purchase_item = FactoryGirl.create(:purchase_item,
                                        :amount => 1,
                                        :vat_type => 'VAT-Inclusive')
      purchase_item.purchase_amount.should eq 1
    end

    it 'should calculate purchase_amount when vat_type is exempted' do
      purchase_item = FactoryGirl.create(:purchase_item,
                                        :amount => 1,
                                        :vat_type => 'VAT-Exempted')
      purchase_item.purchase_amount.should eq 1
    end
  end

  def prepare_purchase_item_macro
    @base_unit = FactoryGirl.create(:unit, :name => 'base')
    @to_unit = FactoryGirl.create(:unit, :name => 'to')
    FactoryGirl.create(:conversion, :bigger_unit => @to_unit, :smaller_unit => @base_unit, :conversion_factor => 2)
    @item = FactoryGirl.create(:item, :unit => @base_unit)
    @purchase_item = FactoryGirl.create(:purchase_item, :item => @item, :quantity => 10, :unit => @to_unit)
  end

  describe '.quantity' do
    before do
      prepare_purchase_item_macro
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
      @purchase_item.qty.unit.symbol.should eq @to_unit.symbol
    end

    it 'should convert to base unit of item' do
      @purchase_item.convert_unit = true
      @purchase_item.quantity.should eq 20
    end
  end

  describe '.unit_cost' do
    before do
      prepare_purchase_item_macro
    end

    it 'should calculate unit_cost without conversion' do
      @purchase_item.convert_unit = false
      @purchase_item.unit_cost.should eq 0.1
    end

    it 'should calculate unit_cost in inventory unit' do
      @purchase_item.convert_unit = true
      @purchase_item.unit_cost.should eq 0.05
    end

    it 'should be net of vat' do
      @purchase_item.update_attribute(:vat_type, 'VAT-Inclusive')
      @purchase_item.unit_cost.should be_between(0.089, 0.09)
    end
  end

  describe '.item_name' do
    it 'should return an item_name' do
      @item = FactoryGirl.create(:item, :name => 'Circlet of Nobility')
      @purchase_item = FactoryGirl.create(:purchase_item, :item => @item, :unit => @item.unit)
      @purchase_item.item_name.should eq 'Circlet of Nobility'
    end
  end

  describe '.subcategory_name' do
    it 'should return a subcategory name' do
      @item = FactoryGirl.create(:item, :subcategory => FactoryGirl.create(:subcategory, name: 'SubA'))
      purchase_item  = FactoryGirl.create(:purchase_item, :item => @item, :unit => @item.unit)
      purchase_item.subcategory_name.should eq 'SubA'
    end
  end

  describe '.unit_name' do
    it 'should return a unit_name' do
      @unit = FactoryGirl.create(:unit, :name => 'kg')
      @item = FactoryGirl.create(:item, :unit => @unit)
      @purchase_item = FactoryGirl.create(:purchase_item, :item => @item, :unit => @unit)
      @purchase_item.unit_name.should eq 'kg'
    end
  end

  context '.available_units' do
    before do
      @base_unit = FactoryGirl.create(:unit)
      @y_unit = FactoryGirl.create(:unit)
      @z_unit = FactoryGirl.create(:unit)
      FactoryGirl.create(:conversion, :bigger_unit => @y_unit, :smaller_unit => @base_unit)
      FactoryGirl.create(:conversion, :bigger_unit => @z_unit, :smaller_unit => @base_unit)
      @item = FactoryGirl.create(:item, :unit => @base_unit)
    end

    it 'should show available units' do
      purchase_item = FactoryGirl.create(:purchase_item, :item => @item, :unit => @base_unit)
      purchase_item.available_units.should eq [ @base_unit, @y_unit, @z_unit ]
    end

    it 'should be invalid without conversion from base unit' do
      other_base_unit = FactoryGirl.create(:unit)
      purchase_item = FactoryGirl.build(:purchase_item, :item => @item, :unit => other_base_unit)
      purchase_item.should have(1).error_on :unit_id
    end

    it 'shoul be valid if unit is equal to base unit' do
      purchase_item = FactoryGirl.build(:purchase_item, :item => @item, :unit => @item.unit)
      purchase_item.should have(0).error_on :unit_id
    end
  end

  context 'Search' do
    before do
      @start_date = 5.days.ago.to_date
      @end_date = Date.today
      @subcategory = FactoryGirl.create(:subcategory, :name => 'SubY')
      @item = FactoryGirl.create(:item, name: 'Magic Wand', :subcategory => @subcategory)
      supplier = FactoryGirl.create(:supplier, name: 'Supplier X')
      @purchase_items = [
        FactoryGirl.create(:purchase_item, :item => @item, :unit => @item.unit,
                            purchase: FactoryGirl.create(:purchase,
                                                         invoice_number: '9090',
                                                         purchase_date: @start_date,
                                                         supplier: supplier)),
        FactoryGirl.create(:purchase_item, :item => @item, :unit => @item.unit,
                            purchase: FactoryGirl.create(:purchase, purchase_date: @end_date))
      ]
    end

    it 'should search by purchase_date' do
      # purchase that should not be included on search result
      FactoryGirl.create(:purchase_item, :item => @item, :unit => @item.unit,
                          purchase: FactoryGirl.create(:purchase, purchase_date: 1.year.ago.to_date))
      search_results = PurchaseItem.search(start_date: @start_date, end_date: @end_date)
      search_results.should eq [@purchase_items[1], @purchase_items[0]]
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
      item = FactoryGirl.create(:item, name: 'other item')
      FactoryGirl.create(:purchase_item, :item => item, :unit => item.unit)
      search_results = PurchaseItem.search(item: 'Magic') # item name that starts with ..
      search_results.should eq [@purchase_items[1], @purchase_items[0]]
    end

    it 'should search by subcategory' do
      subcategory = FactoryGirl.create(:subcategory, :name => 'aaa')
      item = FactoryGirl.create(:item, :subcategory => subcategory)
      FactoryGirl.create(:purchase_item, :item => item, :unit => item.unit)
      search_results = PurchaseItem.search(:subcategory => 'SubY')
      search_results.should eq [@purchase_items[1], @purchase_items[0]]
    end

    it 'should search with combined queries' do
      search_results = PurchaseItem.search(start_date: @start_date, end_date: @end_date, supplier: 'Supplier X')
      search_results.should eq [@purchase_items[0]]
    end
  end
end
