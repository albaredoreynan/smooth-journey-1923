require 'spec_helper'

describe EndcountsController do
  context 'as user' do
    login_user

    context 'when successful' do
      context 'GET #index' do
        before do
          @item = EndcountItem.create(FactoryGirl.attributes_for(:item))
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

    context 'when failing' do
      context 'PUT #update_item_counts' do
        it 'should not crash when there is no items' do
          put 'update_item_counts'
          response.should redirect_to(endcounts_path)
        end
      end
    end
  end

  context 'as branch manager' do
    login_branch

    context 'GET #index' do
      before do
        @other_item = EndcountItem.create(FactoryGirl.attributes_for(:item))
        @item = EndcountItem.create(FactoryGirl.attributes_for(:item, :branch => @current_user.branches.first))
      end

      it 'should load all items' do
        get 'index'
        assigns[:items].should eq [@item]
      end
    end
  end
end
