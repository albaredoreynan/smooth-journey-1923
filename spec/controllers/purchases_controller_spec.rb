require 'spec_helper'

describe PurchasesController do
  login_user

  describe "GET index" do
    it "should show all non-draft purchases" do
      purchase = FactoryGirl.create(:purchase, :save_as_draft => false)
      draft_purchase = FactoryGirl.create(:purchase, :save_as_draft => true)
      get 'index'
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

      it 'should show all purchase without start_date and end_date' do
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
    end

    after do
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

    it 'should load its purchase item' do
      session[:purchase] = @purchase.id
      @purchase_item = FactoryGirl.create(:purchase_item, :purchase => @purchase)
      post :create, :purchase => @post_params
      assigns[:purchase].purchase_items.should eq [@purchase_item]
    end

    it 'should set purchase as non-draft' do
      @purchase.update_attribute(:save_as_draft, true)
      session[:purchase] = @purchase.id
      post :create, :purchase => @post_params
      @purchase.reload.save_as_draft.should eq false
    end

    context 'PUT #update' do
      before do
        @purchase = FactoryGirl.create(:purchase)
        branch = @purchase.branch
        supplier = @purchase.branch
        @put_params = { :supplier_id => supplier.id, :branch_id => branch.id }
      end

      after do
        session.delete :purchase
      end

      it 'should set purchase as non-draft' do
        @purchase.update_attribute(:save_as_draft, true)
        session[:purchase] = @purchase.id
        put 'update', :id => @purchase.id, :purchase => @put_params
        @purchase.reload.save_as_draft.should eq false
      end

      it 'should clear the purchase session' do
        session[:purchase] = @purchase.id
        put 'update', :id => @purchase.id, :purchase => @put_params
        session[:purchase].should be_nil
      end
    end
  end
end
