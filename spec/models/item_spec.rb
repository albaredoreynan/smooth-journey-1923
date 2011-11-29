require "spec_helper"

describe Item do

  it 'should be invalid without a name' do
    @item = Item.new
    @item.should have(1).error_on(:name)
  end

  context 'Subcategory' do
    before do
      @subcat = FactoryGirl.create(:subcategory, :name => 'sub cat')
      @item = FactoryGirl.create(:item, :subcategory_id => @subcat.id)
    end
    it 'should return a category name' do
      @item.category_name.should eq 'Category A'
    end

    it 'should return a subcategory name' do
      @item.subcategory_name.should eq 'sub cat'
    end

    it 'should return nil when no subcategory' do
      item = Item.new
      item.subcategory_name.should be_nil
      item.category_name.should be_nil end
  end

  context 'Search' do
    before do
      @item = Item.create!({:name => 'Item A'})
    end

    it 'should search an item' do
      @items = Item.search('Item A')
      @items.first.name.should eq 'Item A'
    end

    it 'should search an item that begins with a keyword' do
      @items = Item.search('item')
      @items.should eq [@item]
    end

    it 'should not return result if no item found' do
      @items = Item.search('abcdef')
      @items.should be_empty
    end
  end

  context 'Count' do
    before do
      @item_count1 = FactoryGirl.create(:item_count, :count => 5, :created_at => 5.days.ago)
      @item_count2 = FactoryGirl.create(:item_count, :count => 10, :created_at => Time.now)
    end

    it 'should default count to 0' do
      item = Item.create(Factory.attributes_for(:item))
      item.item_count.should eq 0
    end

    it 'should return the latest item count' do
      item = @item_count2.item
      item.item_count.should eq 10
    end
  end
end
