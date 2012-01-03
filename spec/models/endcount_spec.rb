require 'spec_helper'

describe Endcount do

  before do
    @item = FactoryGirl.create(:item)
    @item_counts = [
      FactoryGirl.create(:item_count, :item => @item, :stock_count =>  5, :entry_date => Date.new(2011, 11, 25)),
      FactoryGirl.create(:item_count, :item => @item, :stock_count => 10, :entry_date => Date.new(2012, 1, 2))
    ]
    @endcount = Endcount.new([@item], Date.new(2012, 1, 2), Date.new(2011, 11, 25))
  end

  it 'should set ending count' do
    @endcount.ending_date.should eq Date.new(2012, 1, 2)
  end

  it 'beginning date should defaults to beginning of month' do
    ending_date = Date.new(2012, 1, 2)
    endcount = Endcount.new([@item], ending_date)
    endcount.beginning_date.should eq ending_date.beginning_of_month
  end

  it 'should return beginning_count' do
    @endcount.items.first.beginning_count.should eq 5
  end

  it 'should return ending_count' do
    @endcount.items.first.ending_count.should eq 10
  end
end
