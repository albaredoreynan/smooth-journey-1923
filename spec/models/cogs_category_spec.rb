require 'spec_helper'

describe CogsCategory do
  before do
    @branch = FactoryGirl.create(:branch)

    @subcategory = FactoryGirl.create(:subcategory, :goal => 10)
    @items = [
      FactoryGirl.create(:item, :subcategory => @subcategory),
      FactoryGirl.create(:item, :subcategory => @subcategory)
    ]

    begin_date = Date.today.beginning_of_month

    @item_counts = [
      FactoryGirl.create(:item_count, :item => @items[0], :stock_count => 10, :entry_date => begin_date - 1.day, :branch => @branch),
      FactoryGirl.create(:item_count, :item => @items[1], :stock_count => 20, :entry_date => begin_date - 1.day, :branch => @branch),

      FactoryGirl.create(:item_count, :item => @items[0], :stock_count => 30, :entry_date => Date.today, :branch => @branch),
      FactoryGirl.create(:item_count, :item => @items[1], :stock_count => 40, :entry_date => Date.today, :branch => @branch)
    ]

    @purchases = [
      FactoryGirl.create(:purchase, :purchase_date => begin_date, :branch => @branch),
      FactoryGirl.create(:purchase, :purchase_date => Date.today, :branch => @branch)
    ]

    @purchase_items = [
      FactoryGirl.create(:purchase_item, :purchase => @purchases[0], :item => @items[0], :amount => 5, :unit => @items[0].unit),
      FactoryGirl.create(:purchase_item, :purchase => @purchases[1], :item => @items[1], :amount => 9, :unit => @items[1].unit)
    ]

    @cogs_category = CogsCategory.new(@subcategory, Date.today, @branch)
  end

  context '.beginning' do
    it 'should return beginning count' do
      @cogs_category.beginning.should eq 30
    end
  end

  context '.ending' do
    it 'should return ending count' do
      @cogs_category.ending.should eq 70
    end
  end

  context '.purchase' do
    it 'should return purchase' do
      @cogs_category.purchase.should eq 14
    end
  end

  context '.cogs' do
    it 'should return cogs' do
      @cogs_category.cogs.should eq -26
    end
  end

  context '.purchase_perc' do
    it 'should return purchase percentage' do
      @cogs_category.net_sale_total = 100
      @cogs_category.purchase_perc.should eq 14
    end

    it 'should return nil if net sale total is nil' do
      @cogs_category.purchase_perc.should eq nil
    end

    it 'should return nil if net sale total is 0' do
      @cogs_category.purchase_perc.should eq nil
    end
  end

  context '.cogs_perc' do
    it 'should return cogs perc' do
      @cogs_category.net_sale_total = 100
      @cogs_category.cogs_perc.should eq -26
    end
  end

  context '.var_perc' do
    it 'should return var_perc' do
      @cogs_category.stub(:cogs_perc => -26)
      @cogs_category.var_perc.should eq 36
    end
  end
end
