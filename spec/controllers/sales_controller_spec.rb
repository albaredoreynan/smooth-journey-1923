require 'spec_helper'

describe SalesController do

  context 'as client' do
    login_client

    context 'GET #index' do
      before do
        @restaurant = FactoryGirl.create(:restaurant, :company => @current_company)
        @branch = FactoryGirl.create(:branch, :restaurant => @restaurant)
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
          @sale2 = FactoryGirl.create(:sale, :date => @start_date, :branch => @branch )
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
      before do
        @restaurant = FactoryGirl.create(:restaurant, :company => @current_company)
        @branch = FactoryGirl.create(:branch, :restaurant => @restaurant)
      end

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

      it 'should build sale_category_rows' do
      end
    end

    context 'GET #edit' do
      before do
        @sale = FactoryGirl.create(:sale)
        get 'edit', :id => @sale.id
      end

      it 'should assign an existing Sale' do
        assigns[:sale].should == @sale
      end

      it 'should assign all categories' do
        pending
        assigns[:category_names].should == [@category.name]
      end
    end

    context 'POST #create' do
      it 'should set branch id' do
        post 'create', :sale => FactoryGirl.attributes_for(:sale)
        Sale.find_by_date(Date.today).branch.should eq @branch
      end
    end
  end
end
