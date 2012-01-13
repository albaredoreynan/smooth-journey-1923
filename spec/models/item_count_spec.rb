require 'spec_helper'

describe ItemCount do
  before do
    @unit = FactoryGirl.create(:unit, symbol: 'lbs')
    @item = FactoryGirl.create(:item, unit: @unit)
  end
  it { should belong_to :item }

  it 'should instantiate a quantity object' do
    item_count = FactoryGirl.create(:item_count)
    item_count.quantity.should be_instance_of Quantity
  end

  it "should set the item's default unit when not specified" do
    item_count = FactoryGirl.create(:item_count, item: @item)
    item_count.quantity.unit.should eq @unit
  end

  it 'should save a unit' do
    other_unit = FactoryGirl.create(:unit, symbol: 'xxx')
    item_count = FactoryGirl.create(:item_count, item: @item, unit: other_unit)
    item_count.unit.should eq other_unit
  end

  it 'should save items default unit when not specified' do
    item_count = FactoryGirl.build(:item_count, item: @item)
    item_count.save
    item_count.reload.unit.should eq @unit
  end
end
