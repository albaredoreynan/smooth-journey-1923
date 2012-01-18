require 'spec_helper'

describe EndcountItem do
  before do
    @previous_month = Date.today - 1.month
    @item = EndcountItem.create(FactoryGirl.attributes_for(:item))
    @item_counts = [
      FactoryGirl.create(:item_count, :item => @item, :stock_count => 2, :entry_date => @previous_month.beginning_of_month - 1.day),
      FactoryGirl.create(:item_count, :item => @item, :stock_count => 5, :entry_date => @previous_month),
      FactoryGirl.create(:item_count, :item => @item, :stock_count => 7.5, :entry_date => @previous_month.end_of_month),
      FactoryGirl.create(:item_count, :item => @item, :stock_count =>  10, :entry_date => Date.today)
    ]
  end

  it 'should return beginning_count as last count from previous month' do
    @item.ending_date = Date.today
    @item.beginning_count.should eq 7.5
  end

  it 'should return beginning_count relative to ending_date' do
    @item.ending_date = @previous_month
    @item.beginning_count.should eq 2
  end

  it 'should return ending_count' do
    @item.ending_date = Date.today
    @item.ending_count.should eq 10
  end

  it 'should return ending_count relative to ending_date' do
    @item.ending_date = @previous_month
    @item.ending_count.should eq 5
  end

  context '.purchase_amount_period' do
    before do
      @items = [
        EndcountItem.create(FactoryGirl.attributes_for(:item)),
        EndcountItem.create(FactoryGirl.attributes_for(:item))
      ]
      @purchases = [
        FactoryGirl.create(:purchase,
                           :purchase_date => 5.days.ago,
                           :vat_type => 'VAT-Exempted',
                           :purchase_items => [
                              FactoryGirl.create(:purchase_item, :amount => 5, :item => @items[0]),
                              FactoryGirl.create(:purchase_item, :amount => 6, :item => @items[1])
        ]),
        FactoryGirl.create(:purchase, :purchase_date => Date.today, :purchase_items => [
          FactoryGirl.create(:purchase_item, :amount => 7, :vat_type => 'VAT-Exempted', :item => @items[0]),
          FactoryGirl.create(:purchase_item, :amount => 8, :vat_type => 'VAT-Exempted', :item => @items[1])
        ])
      ]
      @items.map(&:reload)
    end

    it 'should return total amount from a given date period' do
      @items[0].beginning_date = 5.days.ago
      @items[0].ending_date = Date.today
      @items[0].purchase_amount_period.should eq 12
    end
  end

  context '.unit_cost' do
    before do
      @inch_unit = FactoryGirl.create(:unit, :symbol => 'in')
      @cm_unit = FactoryGirl.create(:unit, :symbol => 'cm')
      @conversion = FactoryGirl.create(:conversion,
                                        :bigger_unit => @inch_unit,
                                        :smaller_unit => @cm_unit,
                                        :conversion_factor => 2.54)
      @item = EndcountItem.create(FactoryGirl.attributes_for(:item, :unit => @cm_unit))
      @item.ending_date = Date.today
      @purchase = FactoryGirl.create(:purchase, :purchase_date => Date.today)
    end

    it 'should return 0 if there is no purchase_item' do
      item_with_no_purchase = EndcountItem.create(FactoryGirl.attributes_for(:item))
      item_with_no_purchase.unit_cost.should eq 0
    end

    it 'should return converted' do
      FactoryGirl.create(:purchase_item,
                          :item => @item,
                          :amount => 10,
                          :quantity => 1,
                          :purchase => @purchase,
                          :unit => @inch_unit)
      FactoryGirl.create(:purchase_item,
                          :item => @item,
                          :amount => 5,
                          :quantity => 1,
                          :purchase => @purchase,
                          :unit => @inch_unit)
      @item.unit_cost.should be_between(2.95, 2.953)
    end

    it 'should average until last month' do
      FactoryGirl.create(:purchase_item,
                          item: @item,
                          amount: 30,
                          unit: @item.unit,
                          purchase: FactoryGirl.create(:purchase, purchase_date: 2.months.ago))
      FactoryGirl.create(:purchase_item,
                          item: @item,
                          amount: 10,
                          unit: @item.unit,
                          purchase: FactoryGirl.create(:purchase, purchase_date: 5.days.ago.to_date))
      FactoryGirl.create(:purchase_item,
                          item: @item,
                          amount: 20,
                          unit: @item.unit,
                          purchase: FactoryGirl.create(:purchase, purchase_date: Date.today))
      @item.unit_cost.should eq 15
    end

    it 'should get the last cost if there are no purchases within last month' do
      FactoryGirl.create(:purchase_item,
                          item: @item,
                          amount: 45,
                          unit: @item.unit,
                          purchase: FactoryGirl.create(:purchase, purchase_date: 2.months.ago))
      @item.unit_cost.should eq 45
    end

    it 'should be relative to ending_date' do
      FactoryGirl.create(:purchase_item,
                          item: @item,
                          amount: 100,
                          unit: @item.unit,
                          purchase: FactoryGirl.create(:purchase, :purchase_date => Date.today))
      FactoryGirl.create(:purchase_item,
                          item: @item,
                          amount: 200,
                          unit: @item.unit,
                          purchase: FactoryGirl.create(:purchase, :purchase_date => 5.months.ago.to_date))
      @item.ending_date = 5.months.ago
      @item.unit_cost.should eq 200
    end
  end

  context '.cogs' do
    before do
      @item.stub(
        :purchase_amount_period => 100,
        :beginning_total => 200,
        :ending_total => 50)
    end

    it 'should return a cogs' do
      @item.cogs.should eq 250
    end

    it 'should return nil if any of required parameters are not present' do
      @item.stub(:purchase_amount_period => nil)
      @item.cogs.should be_nil
    end
  end
end
