require 'spec_helper'

describe Endcount do
  before do
    @first_date = Date.new(2011, 12, 25)
    @latter_date = Date.new(2012, 1, 2)
    @item = EndcountItem.create(FactoryGirl.attributes_for(:item))
    @item_counts = [
      FactoryGirl.create(:item_count, :item => @item, :stock_count =>  5, :entry_date => @first_date),
      FactoryGirl.create(:item_count, :item => @item, :stock_count => 10, :entry_date => @latter_date)
    ]
    @endcount = Endcount.new([@item], @latter_date, @first_date)
  end

  it 'should set ending count' do
    @endcount.ending_date.should eq @latter_date
  end

  it 'beginning date should defaults to beginning of month' do
    endcount = Endcount.new([@item], @latter_date)
    endcount.beginning_date.should eq @latter_date.beginning_of_month
  end

  it 'should return beginning_count' do
    pending
    @endcount.items.first.beginning_count.should eq 5
  end

  it 'should return ending_count' do
    @endcount.items.first.ending_count.should eq 10
  end

  it 'should return item counts at specified date' do
    endcount_items = Endcount.ending_counts_at([@item], @first_date)
    endcount_items.first.ending_count.should eq 5
  end
end
