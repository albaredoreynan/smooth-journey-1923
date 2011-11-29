require 'spec_helper'

describe ItemCount do

  it 'should filter items within a date range' do
    @item = FactoryGirl.create(:item)
    FactoryGirl.create(:item_count, :item => @item, :count => 10, :delta => 10, :created_at => 7.days.ago)
    FactoryGirl.create(:item_count, :item => @item, :count => 20, :delta => 10, :created_at => 6.days.ago)
    FactoryGirl.create(:item_count, :item => @item, :count => 15, :delta => -5, :created_at => 5.days.ago)
    FactoryGirl.create(:item_count, :item => @item, :count => 8, :delta => -7, :created_at => 4.days.ago)
    FactoryGirl.create(:item_count, :item => @item, :count => 7, :delta => -1, :created_at => 3.days.ago)
    FactoryGirl.create(:item_count, :item => @item, :count => 100, :delta => 93, :created_at => 2.days.ago)
    FactoryGirl.create(:item_count, :item => @item, :count => 99, :delta => -1, :created_at => 1.days.ago)
  end
end
