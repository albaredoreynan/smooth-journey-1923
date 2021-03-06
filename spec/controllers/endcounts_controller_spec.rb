require 'spec_helper'

describe EndcountsController do
  context 'as admin' do
    login_admin

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
          @item = FactoryGirl.create(:item, item_counts: [FactoryGirl.create(:item_count, :stock_count => 0)])
          @put_params = { :items => { @item.id => { :item_count => 500 } } }
        end

        it 'should mass update item_count' do
          lambda {
            put 'update_item_counts', @put_params
          }.should change {@item.reload.item_count}.from(0).to(500.00)
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

  context 'as client user' do
    login_client

    before do
      restaurant = FactoryGirl.create(:restaurant, :company => @current_company)
      @branch = FactoryGirl.create(:branch, :restaurant => restaurant)
      category = FactoryGirl.create(:category, :restaurant => restaurant)
      subcategory = FactoryGirl.create(:subcategory, :category => category)
      @endcount_item = EndcountItem.create(FactoryGirl.attributes_for(:item, :restaurant => restaurant))
      FactoryGirl.create(:item_count, :item => @endcount_item, :entry_date => Date.today)
    end

    it 'should only show items that owns by the company' do
      get 'index'
      assigns[:items].should eq [ @endcount_item ]
    end

    it 'should only show inventory items' do
      non_inventory_item = EndcountItem.create(FactoryGirl.attributes_for(:item, :branch => @branch, :non_inventory => true))
      get 'index'
      assigns[:items].should eq [ @endcount_item ]
    end

    context 'PUT #update_item_counts' do
      before do
        @item = FactoryGirl.create(:item, item_counts: [FactoryGirl.create(:item_count, :entry_date => Date.today, :stock_count => 0)])
        @put_params = { :entry_date => Date.today.strftime('%F'), :items => { @item.id => { :item_count => 500 } } }
      end

      it 'should be able to update item_count' do
        lambda {
          put 'update_item_counts', @put_params
        }.should change {@item.reload.item_count}.from(0).to(500.00)
      end

      it 'should set a branch' do
        restaurant = FactoryGirl.create(:restaurant, :company => @current_company)
        branch = FactoryGirl.create(:branch, :restaurant => restaurant)
        put 'update_item_counts', @put_params.merge!({:branch_id => branch.id})
      end
    end

  end

  context 'as branch user' do
    login_branch

    before do
      @current_company.settings = { :enable_lock_module => true, :lock_module_in => 1440 }
    end

    context 'GET #index' do
      before do
        EndcountItem.create(FactoryGirl.attributes_for(:item)) # other company
        @item = EndcountItem.create(FactoryGirl.attributes_for(:item, :restaurant => @current_branch.restaurant))
        get 'index'
      end

      it 'should load items within the restaurant' do
        assigns[:items].should eq [@item]
      end

      it 'should load item count for this branch' do
        item_count = FactoryGirl.create(:item_count, :item => @item, :branch => @current_branch, :stock_count => 95)
        FactoryGirl.create(:item_count, :item => @item) # from other branch
        assigns[:items].first.ending_count.should eq 95
      end
    end

    context 'PUT #update_item_counts' do
      before do
        @entry_date = 5.days.ago
        @item = FactoryGirl.create(:item)
        @item_count = FactoryGirl.create(:item_count,
                                         :item => @item,
                                         :branch => @current_branch,
                                         :entry_date => @entry_date.to_date,
                                         :created_at => @entry_date)
        @put_params = { :items => { @item.id => { :item_count => 500 } } }
      end

      it 'should set current branch' do
        put 'update_item_counts', @put_params
        @item.reload.item_counts.last.branch.should eq @current_branch
      end

      it' should be able to update count today' do
        lambda {
          put 'update_item_counts', @put_params
        }.should change{@item.reload.item_count}.to(500)
      end

      it 'should be able to create item count on a specified date' do
        entry_date = 3.days.ago.to_date
        lambda {
          @put_params.merge!(entry_date: entry_date)
          put 'update_item_counts', @put_params
        }.should change{@item.reload.counted_at(entry_date)}
      end

      it 'should NOT be able to update item counts when locked' do
        item_count = @item.counted_at(@entry_date, @current_branch)
        item_count.should eq @item_count
        lambda {
          @put_params.merge!(entry_date: @entry_date.to_date)
          put 'update_item_counts', @put_params
        }.should_not change{@item.reload.counted_at(@entry_date)}
      end
    end
  end
end
