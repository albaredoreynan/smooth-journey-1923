require 'spec_helper'

describe PurchaseItemsController do

  def mock_purchase_item(stubs={})
    (@mock_purchase_item ||= mock_model(PurchaseItem).as_null_object).tap do |purchase_item|
      purchase_item.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all purchase_items as @purchase_items" do
      PurchaseItem.stub(:all) { [mock_purchase_item] }
      get :index
      assigns(:purchase_items).should eq([mock_purchase_item])
    end
  end

  describe "GET show" do
    it "assigns the requested purchase_item as @purchase_item" do
      PurchaseItem.stub(:find).with("37") { mock_purchase_item }
      get :show, :id => "37"
      assigns(:purchase_item).should be(mock_purchase_item)
    end
  end

  describe "GET new" do
    it "assigns a new purchase_item as @purchase_item" do
      PurchaseItem.stub(:new) { mock_purchase_item }
      get :new
      assigns(:purchase_item).should be(mock_purchase_item)
    end
  end

  describe "GET edit" do
    it "assigns the requested purchase_item as @purchase_item" do
      PurchaseItem.stub(:find).with("37") { mock_purchase_item }
      get :edit, :id => "37"
      assigns(:purchase_item).should be(mock_purchase_item)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created purchase_item as @purchase_item" do
        PurchaseItem.stub(:new).with({'these' => 'params'}) { mock_purchase_item(:save => true) }
        post :create, :purchase_item => {'these' => 'params'}
        assigns(:purchase_item).should be(mock_purchase_item)
      end

      it "redirects to the created purchase_item" do
        PurchaseItem.stub(:new) { mock_purchase_item(:save => true) }
        post :create, :purchase_item => {}
        response.should redirect_to(purchase_item_url(mock_purchase_item))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved purchase_item as @purchase_item" do
        PurchaseItem.stub(:new).with({'these' => 'params'}) { mock_purchase_item(:save => false) }
        post :create, :purchase_item => {'these' => 'params'}
        assigns(:purchase_item).should be(mock_purchase_item)
      end

      it "re-renders the 'new' template" do
        PurchaseItem.stub(:new) { mock_purchase_item(:save => false) }
        post :create, :purchase_item => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested purchase_item" do
        PurchaseItem.should_receive(:find).with("37") { mock_purchase_item }
        mock_purchase_item.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :purchase_item => {'these' => 'params'}
      end

      it "assigns the requested purchase_item as @purchase_item" do
        PurchaseItem.stub(:find) { mock_purchase_item(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:purchase_item).should be(mock_purchase_item)
      end

      it "redirects to the purchase_item" do
        PurchaseItem.stub(:find) { mock_purchase_item(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(purchase_item_url(mock_purchase_item))
      end
    end

    describe "with invalid params" do
      it "assigns the purchase_item as @purchase_item" do
        PurchaseItem.stub(:find) { mock_purchase_item(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:purchase_item).should be(mock_purchase_item)
      end

      it "re-renders the 'edit' template" do
        PurchaseItem.stub(:find) { mock_purchase_item(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested purchase_item" do
      PurchaseItem.should_receive(:find).with("37") { mock_purchase_item }
      mock_purchase_item.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the purchase_items list" do
      PurchaseItem.stub(:find) { mock_purchase_item }
      delete :destroy, :id => "1"
      response.should redirect_to(purchase_items_url)
    end
  end

end
