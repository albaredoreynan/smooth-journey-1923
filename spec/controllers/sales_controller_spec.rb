require 'spec_helper'

describe SalesController do
  include Devise::TestHelpers

  before do
    @user = User.create!(:email => 'test@appsource.com', :password => 'password')
    sign_in @user

    @category = FactoryGirl.create(:category)
    @settlement_type = FactoryGirl.create(:settlement_type)
  end

  describe 'GET #index' do
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
            "csrows_attributes"=>{
              "0"=>{
                "category_id"=>@category_a.id,
                "cs_amount"=>"10"},
              "1"=>{
                "category_id"=>@category_b.id,
                "cs_amount"=>"10"},
            },
            "ssrows_attributes"=>{
              "0"=>{
                "settlement_type_id"=>@settlement_type_a.id,
                "ss_amount"=>"10"
              },
              "1"=>{
                "settlement_type_id"=>@settlement_type_b.id,
                "ss_amount"=>"10"
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

      it 'should save csrows' do
        lambda {
          post 'create', @post_param
        }.should change(Csrow, :count).by 2
      end

      it 'should save ssrows' do
        lambda {
          post 'create', @post_param
        }.should change(Ssrow, :count).by 2
      end
    end
  end
end
