require "spec_helper"

describe Item do

  it 'should be invalid without a name' do
    @item = Item.new
    @item.should have(1).error_on(:name)
  end

  context '#branch_location' do
    before do
      @branch = FactoryGirl.create(:branch, :location => 'Leragas The Vile shop')
      @item = FactoryGirl.create(:item, :branch => @branch)
    end

    it 'should return a branch_location' do
      @item.branch_location.should eq 'Leragas The Vile shop'
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
        FactoryGirl.create(:item_count, :item => @item, :stock_count => 10, :entry_date => Time.now)
      ]
    end

    it 'should default count to 0' do
      item = FactoryGirl.create(:item)
      item.item_count.should eq 0
    end

    it 'should return the latest item count' do
      @item.item_count.should eq 10
    end

    it 'should update item count' do
      @item.item_count = 8
      @item.item_count.should eq 8
    end
  end

  context 'Endcount' do
    before do
      @item1 = FactoryGirl.create(:item)
      FactoryGirl.create(:item_count,
                         :item => @item1,
                         :stock_count => 11,
                         :entry_date => 10.days.ago )
      FactoryGirl.create(:item_count,
                         :item => @item1,
                         :stock_count => 10,
                         :entry_date => 5.days.ago )
    end

    it 'should get count from a given date' do
      @item1.counted_at(5.days.ago).should eq 10
      @item1.counted_at(5.days.ago.strftime('%F')).should eq 10;
    end

    it "should display '-' (dash) when no count is found" do
      # epoch time
      @item1.counted_at(Time.at(0)).should eq '-'
    end

    it 'should return items with endcount' do
      @items = Item.endcount(10.days.ago, 5.days.ago)
      @items.first.beginning_count.should eq 11
      @items.first.ending_count.should eq 10
    end
  end
end
