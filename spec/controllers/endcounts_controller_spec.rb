require 'spec_helper'

describe EndcountsController do
  login_user

  context 'GET #index' do
    before do
      @item = FactoryGirl.create(:item)
      @item_counts = [
        FactoryGirl.create(:beginning_of_month_count, :item => @item, :stock_count => 10),
        FactoryGirl.create(:item_count, :item => @item, :stock_count => 20)
      ]
    end

    it 'should load all items' do
      get 'index'
      assigns[:items].should eq [@item]
    end

    it 'should load default item'  do
      # default items from first day of the month to present
      # when start date and end date are not specified
      get 'index'
      item = assigns[:items].first
      item.ending_count.should eq 20
    end

    it 'should load all items with counts at specified date' do
      ItemCount.destroy_all
      FactoryGirl.create(:item_count, :item => @item, :stock_count => 5, :entry_date => 30.days.ago)
      FactoryGirl.create(:item_count, :item => @item, :stock_count => 7)

      get 'index', :date => 30.days.ago.strftime('%F')
      item = assigns[:items].first
      item.ending_count.should eq 5
    end
  end

  context 'GET #new' do
    it 'should load all items' do
      pending
      @item = FactoryGirl.create(:item)
      get 'new'
      assigns[:endcount].item_counts.length.should eq 1
    end

    it 'should pre-loaded the beginning count' do
      pending
      @endcount = FactoryGirl.create(:endcount)
      @item = FactoryGirl.create(:item)
      @item2 = FactoryGirl.create(:item)
      # I inserted two item_counts to make sure that the last item will be
      # fetched regardless of date
      @endcount.item_counts.create ({
        :item_id => @item.id,
        :begin_count => 5,
        :end_count => 10,
        :created_at => 60.seconds.ago
      })
      @endcount.item_counts.create ({
        :item_id => @item.id,
        :begin_count => 10,
        :end_count => 12,
        :created_at => Time.now
      })
      get 'new'
      item_count = assigns[:endcount].item_counts.first
      item_count.begin_count.should eq 12
      item_count.item_id.should eq @item.id
    end
  end

  context 'PUT #update_item_count' do
    before do
      @item = FactoryGirl.create(:item)
      @item_count = FactoryGirl.create(:item_count, :stock_count => 1, :item => @item)
      @put_params = { :items => { @item.id => { :item_count => 500 } } }
    end

    it 'should mass update item_count' do
      lambda {
        put 'update_item_counts', @put_params
      }.should change {@item.reload.item_count}.from(1.0).to(500.00)
    end

    it 'should not create a new record when param is blank' do
      @put_params[:items][@item.id][:item_count] = ''
      lambda {
        put 'update_item_counts', @put_params
      }.should_not change{@item.reload.item_counts.count}

      FactoryGirl.create(:item_count, :item => @item, :entry_date => 5.days.ago)
      @put_params.merge!(:entry_date => 5.days.ago.strftime('%F'))
      lambda {
        put 'update_item_counts', @put_params
      }.should_not change{@item.reload.item_counts.count}
    end

    it 'should update item_count specified by date' do
      @put_params.merge!(:entry_date => 5.days.ago.strftime('%F'))
      put 'update_item_counts', @put_params
      item_count = @item.reload.counted_at(5.days.ago)
      item_count.try(:stock_count).should eq 500
    end
  end
end
