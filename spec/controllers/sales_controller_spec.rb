require 'spec_helper'

describe SalesController do
  login_user

  before do
    @category = FactoryGirl.create(:category)
    @settlement_type = FactoryGirl.create(:settlement_type)
  end

  context 'GET #index' do
    before do
      @sale = FactoryGirl.create(:sale)
    end

    it 'should load all sales' do
      get 'index'
      assigns[:sales].should eq ({Date.today => [@sale]})
    end

    context 'Search' do
      before do
        @start_date = 5.days.ago
        @sale2 = FactoryGirl.create(:sale, :date => @start_date )
      end

      it 'should filter sale by date' do
        get 'index', :start_date => @start_date.to_date, :end_date => Date.today.strftime('%F')
        assigns[:sales].should eq ({Date.today => [@sale], @start_date.to_date => [@sale2]})
      end

      it 'should filter sale with start_date but without end_date' do
        get 'index', :start_date => @start_date.to_date, :end_date => ''
        assigns[:sales].should eq ({Date.today => [@sale], @start_date.to_date => [@sale2]})
      end

      it 'should filter sale with end_date but without start_date' do
        get 'index', :start_date => '', :end_date => Date.today.strftime('%F')
        assigns[:sales].should eq ({Date.today => [@sale], @start_date.to_date => [@sale2]})
      end
      
      it 'should filter sale without start_date and end_date' do
        get 'index', :start_date => '', :end_date => ''
        assigns[:sales].should eq ({Date.today => [@sale], @start_date.to_date => [@sale2]})
      end
    end
  end
  
  context 'GET #sales_by_settlement_type' do
    before do
      @sale = FactoryGirl.create(:sale)
    end

    it 'should load all sales by settlement type' do
      get 'sales_by_settlement_type'
      assigns[:sales].should eq ({Date.today => [@sale]})
    end

    context 'Search' do
      before do
        @start_date = 5.days.ago
        @sale2 = FactoryGirl.create(:sale, :date => @start_date )
      end

      it 'should filter sale by date' do
        get 'index', :start_date => @start_date.to_date, :end_date => Date.today.strftime('%F')
        assigns[:sales].should eq ({Date.today => [@sale], @start_date.to_date => [@sale2]})
      end

      it 'should filter sale with start_date but without end_date' do
        get 'index', :start_date => @start_date.to_date, :end_date => ''
        assigns[:sales].should eq ({Date.today => [@sale], @start_date.to_date => [@sale2]})
      end

      it 'should filter sale with end_date but without start_date' do
        get 'index', :start_date => '', :end_date => Date.today.strftime('%F')
        assigns[:sales].should eq ({Date.today => [@sale], @start_date.to_date => [@sale2]})
      end
      
      it 'should filter sale without start_date and end_date' do
        get 'index', :start_date => '', :end_date => ''
        assigns[:sales].should eq ({Date.today => [@sale], @start_date.to_date => [@sale2]})
      end
    end
  end
  describe 'GET #new' do
    before do
      get 'new'
    end

    it 'should assign a new Sale' do
      assigns[:sale].should_not be_nil
      assigns[:sale].should be_kind_of(Sale)
      assigns[:sale].should be_new_record
    end

    it 'should assign all categories' do
      assigns[:category_names].should == [@category.name]
      assigns[:category_ids].should == [@category.id]
    end

    it 'should assign all settlement types' do
      assigns[:settlement_type_names].should == [@settlement_type.name]
      assigns[:settlement_type_ids].should == [@settlement_type.id]
    end

    context 'Category Sale' do
      it 'should have blank a category_sales' do
        assigns[:sale].category_sales.should_not be_empty
        assigns[:sale].category_sales.length.should eq 1
      end

      it 'should default category_id to Category' do
        assigns[:sale].category_sales.first.category_id.should eq @category.id
      end
    end

    context 'Settlement Type Sale' do
      it 'should have a blank settlement_type_sales' do
        assigns[:sale].settlement_type_sales.should_not be_empty
        assigns[:sale].settlement_type_sales.length.should eq 1
      end

      it 'should default settlement_type_id to Settlement' do
        assigns[:sale].settlement_type_sales.first.settlement_type_id.should eq @settlement_type.id
      end
    end
  end

  describe 'GET #edit' do
    before do
      @sale = FactoryGirl.create(:sale)
      get 'edit', :id => @sale.id
    end

    it 'should assign an existing Sale' do
      assigns[:sale].should == @sale
    end

    it 'should assign all categories' do
      assigns[:category_names].should == [@category.name]
    end
  end

  describe 'POST #create' do
    context 'when successful' do
      before do
        @category_a = FactoryGirl.create(:category)
        @category_b = FactoryGirl.create(:category, :name => 'Category B')

        @settlement_type_a = FactoryGirl.create(:settlement_type)
        @settlement_type_b = FactoryGirl.create(:settlement_type, :name => 'Gift cheque')

        @post_param = {
          "sale"=>{
            "branch_id"=>"1",
            "date(1i)"=>"2011",
            "date(2i)"=>"11",
            "date(3i)"=>"16",
            "employee_id"=>"",
            "customer_count"=>"100",
            "transaction_count"=>"50",
            "total_amount_cs"=>"30",
            "total_revenue_cs"=>"10",
            "service_charge"=>"10",
            "void"=>"1",
            "vat"=>"2.4",
            "gross_total_ss"=>"20",
            "net_total_ss"=>"17.6",
            "dinein_cc"=>"10",
            "delivery_sales"=>"10",
            "dinein_tc"=>"10",
            "delivery_tc"=>"10",
            "dinein_ppa"=>"10",
            "delivery_pta"=>"10",
            "dinein_pta"=>"10",
            "takeout_tc"=>"10",
            "takeout_pta"=>"10",
            "category_sales_attributes"=>{
              "0"=>{
                "category_id"=>@category_a.id,
                "amount"=>"10"},
              "1"=>{
                "category_id"=>@category_b.id,
                "amount"=>"10"},
            },
            "settlement_type_sales_attributes"=>{
              "0"=>{
                "settlement_type_id"=>@settlement_type_a.id,
                "amount"=>"10"
              },
              "1"=>{
                "settlement_type_id"=>@settlement_type_b.id,
                "amount"=>"10"
              }
            },
          },
          "vat"=>"",
          "gross_total"=>"",
          "commit"=>"Save as Draft"
        }
      end

      it 'should save a new sale' do
        lambda {
          post 'create', @post_param
        }.should change(Sale, :count).by 1
      end

      it 'should save category sales' do
        lambda {
          post 'create', @post_param
        }.should change(CategorySale, :count).by 2
      end

      it 'should save settlement type sales' do
        lambda {
          post 'create', @post_param
        }.should change(SettlementTypeSale, :count).by 2
      end
    end
  end
end
