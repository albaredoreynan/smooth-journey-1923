require 'spec_helper'

describe EndcountsController do
  login_user

  context 'GET #index' do
    it 'should load all endcounts' do
      pending
      @endcount = FactoryGirl.create(:endcount)
      get 'index'
      assigns[:endcounts].should eq [@endcount]
    end
  end

  context 'GET #search' do
    it 'should filter all endcounts by date' do
      begin_date = 30.days.ago
      end_date = Date.today
      endcount1 = FactoryGirl.create(:endcount, :begin_date => 30.days.ago,
                                                 :end_date => 15.days.ago)
      endcount2 = FactoryGirl.create(:endcount, :begin_date => 7.days.ago,
                                                 :end_date => 2.days.ago)
      get 'index', ({
        "start"=>{
          "(1i)"=> begin_date.year,
          "(2i)"=> begin_date.month,
          "(3i)"=> begin_date.day},
        "end"=>{
          "(1i)"=> end_date.year,
          "(2i)"=> end_date.month,
          "(3i)"=> end_date.day},
        "commit"=>"Search",
        "id"=>"search"})
      assigns[:endcounts].should eq [endcount1, endcount2]
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
end
