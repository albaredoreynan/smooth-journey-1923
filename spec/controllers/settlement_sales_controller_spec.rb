require 'spec_helper'

describe SettlementSalesController do

  def mock_settlement_sale(stubs={})
    (@mock_settlement_sale ||= mock_model(SettlementSale).as_null_object).tap do |settlement_sale|
      settlement_sale.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all settlement_sales as @settlement_sales" do
      SettlementSale.stub(:all) { [mock_settlement_sale] }
      get :index
      assigns(:settlement_sales).should eq([mock_settlement_sale])
    end
  end

  describe "GET show" do
    it "assigns the requested settlement_sale as @settlement_sale" do
      SettlementSale.stub(:find).with("37") { mock_settlement_sale }
      get :show, :id => "37"
      assigns(:settlement_sale).should be(mock_settlement_sale)
    end
  end

  describe "GET new" do
    it "assigns a new settlement_sale as @settlement_sale" do
      SettlementSale.stub(:new) { mock_settlement_sale }
      get :new
      assigns(:settlement_sale).should be(mock_settlement_sale)
    end
  end

  describe "GET edit" do
    it "assigns the requested settlement_sale as @settlement_sale" do
      SettlementSale.stub(:find).with("37") { mock_settlement_sale }
      get :edit, :id => "37"
      assigns(:settlement_sale).should be(mock_settlement_sale)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created settlement_sale as @settlement_sale" do
        SettlementSale.stub(:new).with({'these' => 'params'}) { mock_settlement_sale(:save => true) }
        post :create, :settlement_sale => {'these' => 'params'}
        assigns(:settlement_sale).should be(mock_settlement_sale)
      end

      it "redirects to the created settlement_sale" do
        SettlementSale.stub(:new) { mock_settlement_sale(:save => true) }
        post :create, :settlement_sale => {}
        response.should redirect_to(settlement_sale_url(mock_settlement_sale))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved settlement_sale as @settlement_sale" do
        SettlementSale.stub(:new).with({'these' => 'params'}) { mock_settlement_sale(:save => false) }
        post :create, :settlement_sale => {'these' => 'params'}
        assigns(:settlement_sale).should be(mock_settlement_sale)
      end

      it "re-renders the 'new' template" do
        SettlementSale.stub(:new) { mock_settlement_sale(:save => false) }
        post :create, :settlement_sale => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested settlement_sale" do
        SettlementSale.should_receive(:find).with("37") { mock_settlement_sale }
        mock_settlement_sale.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :settlement_sale => {'these' => 'params'}
      end

      it "assigns the requested settlement_sale as @settlement_sale" do
        SettlementSale.stub(:find) { mock_settlement_sale(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:settlement_sale).should be(mock_settlement_sale)
      end

      it "redirects to the settlement_sale" do
        SettlementSale.stub(:find) { mock_settlement_sale(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(settlement_sale_url(mock_settlement_sale))
      end
    end

    describe "with invalid params" do
      it "assigns the settlement_sale as @settlement_sale" do
        SettlementSale.stub(:find) { mock_settlement_sale(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:settlement_sale).should be(mock_settlement_sale)
      end

      it "re-renders the 'edit' template" do
        SettlementSale.stub(:find) { mock_settlement_sale(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested settlement_sale" do
      SettlementSale.should_receive(:find).with("37") { mock_settlement_sale }
      mock_settlement_sale.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the settlement_sales list" do
      SettlementSale.stub(:find) { mock_settlement_sale }
      delete :destroy, :id => "1"
      response.should redirect_to(settlement_sales_url)
    end
  end

end
