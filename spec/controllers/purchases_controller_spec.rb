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
        @purchases = [ FactoryGirl.create(:purchase, :purchase_date => @start_date ), FactoryGirl.create(:purchase, :purchase_date => Date.today) ]
      end

      it 'should filter purchase by date' do
        get 'index', :start_date => @start_date.to_date, :end_date => Date.today.strftime('%F')
        assigns[:purchases].should eq [@purchases.first, @purchases.last]
      end

      it 'should filter purchase with start_date but without end_date' do
        get 'index', :start_date => @start_date.to_date, :end_date => ''
        assigns[:purchases].should eq [@purchases.first, @purchases.last]
      end

      it 'should filter purchase with end_date but without start_date' do
        get 'index', :start_date => '', :end_date => Date.today.strftime('%F')
        assigns[:purchases].should eq [@purchases.first, @purchases.last]
      end

      it 'should filter purchase without start_date and end_date' do
        get 'index', :start_date => '', :end_date => ''
        assigns[:purchases].should eq [@purchases.first, @purchases.last]
      end
    end
  end

  describe 'GET #new' do
    before do
      @purchase = FactoryGirl.create(:purchase)
      session.delete :purchase
    end

    it 'should create a new Purchase' do
      get 'new'
      assigns[:purchase].should be_kind_of(Purchase)
    end

    it 'should assign a purchase id on session' do
      get 'new'
      session[:purchase].should_not be_nil
    end

    it 'should restore a purchase' do
      session[:purchase] = @purchase.id
      get 'new'
      assigns[:purchase].should eq @purchase
    end

    it 'should reset purchase if purchase id was not found' do
      session[:purchase] = 'x'
      get 'new'
      response.should be_successful
    end
  end

  describe 'POST #create' do
    before do
      @purchase = FactoryGirl.create(:purchase)
      supplier = @purchase.supplier
      branch = @purchase.branch
      @post_params = { supplier_id: supplier.id, branch_id: branch.id }
      session.delete :purchase
    end

    it 'should create a new Purchase' do
      session[:purchase].should be_nil
      lambda {
        post :create, :purchase => @post_params
      }.should change(Purchase, :count).by(1)
    end

    it 'should restore a Purchase' do
      session[:purchase] = @purchase.id
      lambda {
        post :create, :purchase => @post_params
      }.should_not change(Purchase, :count)
      assigns[:purchase].should eq @purchase
    end

  end

  describe 'PUT #update' do
    before do
      @purchase = FactoryGirl.create(:purchase)
      supplier = @purchase.supplier
      branch = @purchase.branch
      @post_params = { supplier_id: supplier.id, branch_id: branch.id }
    end

    it 'should save a purchase' do
      put :update, :id => @purchase.id
    end
  end
end
