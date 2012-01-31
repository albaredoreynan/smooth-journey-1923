require "spec_helper"

describe Item do

  it 'should be invalid without a name' do
    @item = Item.new
    @item.should have(1).error_on(:name)
  end

  context '.branch_location' do
    before do
      @branch = FactoryGirl.create(:branch, :location => 'Leragas The Vile shop')
      @item = FactoryGirl.create(:item, :branch => @branch)
    end

    it 'should return a branch_location' do
      @item.branch_location.should eq 'Leragas The Vile shop'
    end
  end

  context '.unit_name' do
    before do
      @unit = FactoryGirl.create(:unit, :symbol => 'kg', :name => 'Kilogram')
      @item = FactoryGirl.create(:item, :unit => @unit)
    end

    it 'should return a unit_name' do
      @item.unit_name.should eq 'Kilogram'
    end

    it 'should return a symbol if there is no name' do
      @unit.update_attribute(:name, nil)
      @item.unit_name.should eq 'kg'
    end
  end

  context 'Subcategory' do
    before do
      @category = FactoryGirl.create(:category, :name => 'Dota Items')
      @subcategory = FactoryGirl.create(:subcategory, :name => 'Gateway Relics', :category => @category)
      @item = FactoryGirl.create(:item, :name => 'Wraith Band', :subcategory => @subcategory )
    end
    it 'should return a category name' do
      @item.category_name.should eq 'Dota Items'
    end

    it 'should return a subcategory name' do
      @item.subcategory_name.should eq 'Gateway Relics'
    end

    it 'should return nil when no subcategory' do
      item = Item.new
      item.subcategory_name.should be_nil
      item.category_name.should be_nil end
  end

  context 'Search' do
    before do
      @item1 = FactoryGirl.create(:item, :name => 'Null Talisman')
    end

    it 'should search an item' do
      @items = Item.search('Null Talisman')
      @items.should eq [@item1]
    end

    it 'should search an item that begins with a keyword' do
      @items = Item.search('null')
      @items.should eq [@item1]
    end

    it 'should not return result if no item found' do
      @items = Item.search('does not exists')
      @items.should be_empty
    end
  end

  context 'Count' do
    before do
      @item = FactoryGirl.create(:item)
      @item_counts = [
        FactoryGirl.create(:item_count, :item => @item, :stock_count => 5, :entry_date => 5.days.ago),
        FactoryGirl.create(:item_count, :item => @item, :stock_count => 10, :entry_date => Date.today)
      ]
    end

    it 'should default count to 0' do
      no_count_item = FactoryGirl.create(:item)
      no_count_item.item_count.should eq 0
    end

    it 'should return the latest item count' do
      @item.item_count.should eq 10
    end

    it 'should update item count' do
      @item.item_count = 8
      @item.item_count.should eq 8
    end

    it 'should only one count per day' do
      @item.item_counts.where(:entry_date => Date.today).count.should eq 1
      lambda {
        @item.item_count = 500
      }.should_not change{@item.item_counts.count}
    end

    it 'should update count' do
      @item.update_count(456)
      @item.item_count.should eq 456
    end

    it 'should update count given a specified date' do
      @item.update_count(234, 5.days.ago)
      @item.counted_at(5.days.ago).try(:stock_count).should eq 234
    end

    it 'should return the latest entry when there are two counts within the day' do
      FactoryGirl.create(:item_count, :item => @item, :stock_count => 7.5, :entry_date => 5.days.ago.to_date)
      @item.counted_at(5.days.ago).try(:stock_count).should eq 7.5
    end
  end
end
