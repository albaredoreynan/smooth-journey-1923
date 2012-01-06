require 'spec_helper'

describe EndcountItem do
  before do
    @previous_month = Date.today - 1.month
    @item = EndcountItem.create(FactoryGirl.attributes_for(:item))
    @item_counts = [
      FactoryGirl.create(:item_count, :item => @item, :stock_count => 5, :entry_date => @previous_month),
      FactoryGirl.create(:item_count, :item => @item, :stock_count => 7.5, :entry_date => @previous_month.end_of_month),
      FactoryGirl.create(:item_count, :item => @item, :stock_count => 10, :entry_date => Date.today)
    ]
  end

  it 'should return last count from previous month' do
    @item.ending_date = Date.today
    @item.last_count_from_previous_month.should eq 7.5
  end

  context '#purchase_amount_period' do
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

  context '#average_unit_cost' do
    before do
      @inch_unit = FactoryGirl.create(:unit, :symbol => 'in')
      @cm_unit = FactoryGirl.create(:unit, :symbol => 'cm')
      @conversion = FactoryGirl.create(:conversion,
                                        :bigger_unit => @inch_unit,
                                        :smaller_unit => @cm_unit,
                                        :conversion_factor => 2.54)
      @item = EndcountItem.create(FactoryGirl.attributes_for(:item, :unit => @cm_unit))
      @purchase = FactoryGirl.create(:purchase, :purchase_date => Date.today)
      @purchase_items = [
        FactoryGirl.create(:purchase_item,
                            :item => @item,
                            :amount => 10,
                            :quantity => 1,
                            :purchase => @purchase,
                            :unit => @inch_unit),
        FactoryGirl.create(:purchase_item,
                            :item => @item,
                            :amount => 5,
                            :quantity => 1,
                            :purchase => @purchase,
                            :unit => @inch_unit)
      ]
    end

    it 'should return 0 average_unit_cost if there is no purchase_item' do
      item_with_no_purchase = EndcountItem.create(FactoryGirl.attributes_for(:item))
      item_with_no_purchase.average_unit_cost.should eq 0
    end

    it 'should return a unit cost average with conversion' do
      @item.average_unit_cost.should be_between(2.95, 2.953)
    end
  end

  context '#cogs' do
    it 'should return a cogs' do
      @item.stub(
        :purchase_amount_period => 100,
        :beginning_total => 200,
        :ending_total => 50)
      @item.cogs.should eq 250
    end
  end
end
