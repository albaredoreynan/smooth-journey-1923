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
      item.category_name.should be_nil
    end
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

  context 'Endcount' do
    before do
      @endcount = FactoryGirl.create(:endcount)
      @item = FactoryGirl.create(:item)
      @item_count = FactoryGirl.create(:item_count, {
        endcount: @endcount,
        item: @item,
        begin_count: 0,
        end_count: 5
      })
    end

    it 'should return the last count' do
      @item.end_count.should eq 5
    end

    it 'should return 0 count if there is no endcount' do
      Endcount.destroy_all
      @item.end_count.should eq 0
    end
  end
end
