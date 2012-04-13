require 'spec_helper'

describe SalesController do

  context 'as client' do
    login_client

    before do
      @restaurant = FactoryGirl.create(:restaurant, :company => @current_company)
      @branch = FactoryGirl.create(:branch, :restaurant => @restaurant)
    end

    context 'GET #index' do
      before do
        @sale = FactoryGirl.create(:sale, :branch => @branch)
      end

      it "should load all client's sales" do
        FactoryGirl.create(:sale)
        get 'index'
        assigns[:sales].should eq [@sale]
      end

      context 'Search' do
        before do
          @start_date = 5.days.ago
          @sale2 = FactoryGirl.create(:sale, :sale_date => @start_date, :branch => @branch )
        end

        it 'should filter sale by date' do
          get 'index', :start_date => @start_date.to_date, :end_date => Date.today.strftime('%F')
          assigns[:sales].should eq [@sale, @sale2]
        end

        it 'should filter sale with start_date but without end_date' do
          get 'index', :start_date => @start_date.to_date, :end_date => ''
          assigns[:sales].should eq [@sale, @sale2]
        end

        it 'should filter sale with end_date but without start_date' do
          get 'index', :start_date => '', :end_date => Date.today.strftime('%F')
          assigns[:sales].should eq [@sale, @sale2]
        end

        it 'should filter sale without start_date and end_date' do
          get 'index', :start_date => '', :end_date => ''
          assigns[:sales].should eq [@sale, @sale2]
        end
      end
    end

    context 'GET #new' do
      it 'should assign a new Sale' do
        get 'new'
        assigns[:sale].should_not be_nil
        assigns[:sale].should be_kind_of(Sale)
        assigns[:sale].should be_new_record
      end

      it "should build client's categories" do
        FactoryGirl.create(:sale_category) # other sale_category that should not be included
        @categories = [
          FactoryGirl.create(:sale_category, :restaurant => @restaurant),
          FactoryGirl.create(:sale_category, :restaurant => @restaurant)
        ]
        get 'new'
        assigns[:sale].sale_category_rows.map(&:category_id).sort.should eq [ @categories[0].id, @categories[1].id ]
      end

      it "should build client's settlement types" do
        settlement_type = FactoryGirl.create(:settlement_type, :branch => @branch)
        FactoryGirl.create(:settlement_type) # other settlement type
        get 'new'
        assigns[:sale].settlement_type_sales.map(&:settlement_type_id).should eq [settlement_type.id]
      end
    end

    context 'GET #edit' do
      before do
        FactoryGirl.create(:sale_category) # other sale_category that should not be included
        @categories = [
          FactoryGirl.create(:sale_category, :restaurant => @restaurant),
          FactoryGirl.create(:sale_category, :restaurant => @restaurant)
        ]
        @sale = FactoryGirl.create(:sale)
        @sale_category_rows = [
          FactoryGirl.create(:sale_category_row, :sale => @sale, :category => @categories[0]),
          FactoryGirl.create(:sale_category_row, :sale => @sale, :category => @categories[1]),
        ]
        get 'edit', :id => @sale.id
      end

      it 'should assign an existing Sale' do
        assigns[:sale].should == @sale
      end

      it 'should load sale categories' do
        assigns[:sale].sale_category_rows.map(&:category_id).sort.should eq [ @categories[0].id, @categories[1].id ]
      end
    end

    context 'POST #create' do
      it 'should save a sale' do
        sale_categories = [
          FactoryGirl.create(:sale_category, :name => 'Food', :restaurant => @restaurant),
          FactoryGirl.create(:sale_category, :name => 'Beverage', :restaurant => @restaurant),
          FactoryGirl.create(:sale_category, :name => 'Beer', :restaurant => @restaurant),
          FactoryGirl.create(:sale_category, :name => 'Liquor', :restaurant => @restaurant),
        ]
        settlement_types = [
          FactoryGirl.create(:settlement_type, :name => 'Cash', :branch => @branch),
          FactoryGirl.create(:settlement_type, :name => 'Credit Card', :branch => @branch),
          FactoryGirl.create(:settlement_type, :name => 'Comp 91', :branch => @branch),
          FactoryGirl.create(:settlement_type, :name => 'Comp 92', :branch => @branch),
          FactoryGirl.create(:settlement_type, :name => 'Comp 93', :branch => @branch),
          FactoryGirl.create(:settlement_type, :name => 'Comp 94', :branch => @branch),
          FactoryGirl.create(:settlement_type, :name => 'Comp 95', :branch => @branch),
          FactoryGirl.create(:settlement_type, :name => 'Comp 96', :branch => @branch),
          FactoryGirl.create(:settlement_type, :name => 'Comp 97', :branch => @branch),
        ]
        servers = [
          FactoryGirl.create(:server, :branch => @branch),
          FactoryGirl.create(:server, :branch => @branch),
        ]

        post_params = {
          :branch_id => @branch.id, :sale_date => Date.today,
          :sale_category_rows_attributes => {
            0 => { :category_id => sale_categories[0].id, :amount => 100_000.00 }, # food
            1 => { :category_id => sale_categories[1].id, :amount =>  10_000.00 }, # beverage
            2 => { :category_id => sale_categories[2].id, :amount =>   1_000.00 }, # beer
            3 => { :category_id => sale_categories[3].id, :amount =>     100.00 }, # liquor
          },
          :vat =>                13_332.00,
          :service_charge =>        11_110,
          :settlement_type_sales_attributes => {
            0 => { :settlement_type_id => settlement_types[0].id, :amount => 98_345.00 },
            1 => { :settlement_type_id => settlement_types[1].id, :amount => 24_654.00 },
            2 => { :settlement_type_id => settlement_types[2].id, :amount =>    367.00 },
            3 => { :settlement_type_id => settlement_types[3].id, :amount =>  2_927.00 },
            4 => { :settlement_type_id => settlement_types[4].id, :amount =>    413.00 },
            5 => { :settlement_type_id => settlement_types[5].id, :amount =>     13.00 },
            6 => { :settlement_type_id => settlement_types[6].id, :amount =>       nil },
            7 => { :settlement_type_id => settlement_types[7].id, :amount =>       nil },
            8 => { :settlement_type_id => settlement_types[8].id, :amount =>       nil },
          },
          :sale_servers_attributes => {
            0 => { :server_id => servers[0], :amount => 100_000.00 },
            1 => { :server_id => servers[1], :amount =>   3_794.78 }
          },
          :gc_redeemed =>         1_000.00,
          :delivery_sales =>      7_823.00,
          :customer_count =>           489,
          :transaction_count =>        183,
          :cash_in_drawer =>     98_344.78,
          :gc_sales =>            5_000.00,
          :other_income =>          450.00,
        }
        lambda {
          post 'create', :sale => post_params
        }.should change(Sale, :count).by(1)
      end
    end

    context 'DELETE #destroy' do
      before do
        @sale = FactoryGirl.create(:sale, :branch => @branch)
      end

      it 'should be able to destroy a sale' do
        lambda {
          delete 'destroy', :id => @sale.id
        }.should change(Sale, :count).by -1
      end
    end
  end

  context 'as branch manager' do
    login_branch

    context 'GET #index' do
      it 'should only show sales from branch' do
        @sale = FactoryGirl.create(:sale, :branch => @current_branch)
        @other_restaurant = FactoryGirl.create(:restaurant, :company => @current_company)
        @other_branch = FactoryGirl.create(:branch, :restaurant => @other_restaurant)
        FactoryGirl.create(:sale, :branch => @other_branch)
        get 'index'
        assigns[:sales].should eq [@sale]
      end
    end
  end
end
