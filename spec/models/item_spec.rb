require "spec_helper"

describe Item do
  
  it 'should be invalid without a name' do
    @item = Item.new
    @item.should have(1).error_on(:name)  
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
      @items.first.name.should == 'Item A'
    end
    
    it 'should not return result if no item found' do
      @items = Item.search('abcdef')
      @items.should be_empty
    end
  end
end