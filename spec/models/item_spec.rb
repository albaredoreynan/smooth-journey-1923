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
end
