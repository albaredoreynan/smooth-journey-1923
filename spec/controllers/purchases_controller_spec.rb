require 'spec_helper'

describe PurchasesController do
  login_user

  describe "GET index" do
    it "assigns all purchases as @purchases" do
      purchase = FactoryGirl.create(:purchase)
      get :index
      assigns[:purchases].should eq [purchase]
    end

    context "Search" do
      before do
        @start_date = 5.days.ago
        @purchase1 = FactoryGirl.create(:purchase, :purchase_date => @start_date )
        @purchase2 = FactoryGirl.create(:purchase, :purchase_date => Date.today)
      end

      it 'should filter purchase by date' do
        get 'index', :start_date => @start_date.to_date, :end_date => Date.today.strftime('%F')
        assigns[:purchases].should eq [@purchase1, @purchase2]
      end

      it 'should filter purchase with start_date but without end_date' do
        get 'index', :start_date => @start_date.to_date, :end_date => ''
        assigns[:purchases].should eq [@purchase1, @purchase2]
      end

      it 'should filter purchase with end_date but without start_date' do
        get 'index', :start_date => '', :end_date => Date.today.strftime('%F')
        assigns[:purchases].should eq [@purchase1, @purchase2]
      end

      it 'should filter purchase without start_date and end_date' do
        get 'index', :start_date => '', :end_date => ''
        assigns[:purchases].should eq [@purchase1, @purchase2]
      end

      # it 'should filter purchase without start_date and end_date' do
        # get 'index', :commit => 'Search'
        # assigns[:purchases].should eq [@purchase1, @purchase2]
      # end
    end
  end

  describe 'POST #create' do
    before do
      branch = FactoryGirl.create(:branch)
      supplier = FactoryGirl.create(:supplier)
      @post_params = {:supplier_id => supplier.id, :branch_id => branch.id, :invoice_id => 1}
    end

    it 'should redirect to index' do
      post :create, :purchase => @post_params
      response.should redirect_to(purchases_path)
    end

    it 'should assign purchase' do
      post :create, :purchase => @post_params
      assigns[:purchase].should_not be_nil
      assigns[:purchase].should be_kind_of(Purchase)
    end

    it 'should create a record' do
      lambda {
        post :create, :purchase => @post_params
      }.should change(Purchase, :count).by(1)
    end

    it 'should be able to assign vat-amount and net-amount variables from purchase_items' do
      pending
      post :create, :purchase => @post_params.merge(
        {:purchase_items_attributes => {0 =>{:vat_amount => 10, :net_amount => 10}}})
    end
  end
end
