require 'spec_helper'

describe SettlementTypesController do

  def mock_settlement_type(stubs={})
    (@mock_settlement_type ||= mock_model(SettlementType).as_null_object).tap do |settlement_type|
      settlement_type.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all settlement_types as @settlement_types" do
      SettlementType.stub(:all) { [mock_settlement_type] }
      get :index
      assigns(:settlement_types).should eq([mock_settlement_type])
    end
  end

  describe "GET show" do
    it "assigns the requested settlement_type as @settlement_type" do
      SettlementType.stub(:find).with("37") { mock_settlement_type }
      get :show, :id => "37"
      assigns(:settlement_type).should be(mock_settlement_type)
    end
  end

  describe "GET new" do
    it "assigns a new settlement_type as @settlement_type" do
      SettlementType.stub(:new) { mock_settlement_type }
      get :new
      assigns(:settlement_type).should be(mock_settlement_type)
    end
  end

  describe "GET edit" do
    it "assigns the requested settlement_type as @settlement_type" do
      SettlementType.stub(:find).with("37") { mock_settlement_type }
      get :edit, :id => "37"
      assigns(:settlement_type).should be(mock_settlement_type)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created settlement_type as @settlement_type" do
        SettlementType.stub(:new).with({'these' => 'params'}) { mock_settlement_type(:save => true) }
        post :create, :settlement_type => {'these' => 'params'}
        assigns(:settlement_type).should be(mock_settlement_type)
      end

      it "redirects to the created settlement_type" do
        SettlementType.stub(:new) { mock_settlement_type(:save => true) }
        post :create, :settlement_type => {}
        response.should redirect_to(settlement_type_url(mock_settlement_type))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved settlement_type as @settlement_type" do
        SettlementType.stub(:new).with({'these' => 'params'}) { mock_settlement_type(:save => false) }
        post :create, :settlement_type => {'these' => 'params'}
        assigns(:settlement_type).should be(mock_settlement_type)
      end

      it "re-renders the 'new' template" do
        SettlementType.stub(:new) { mock_settlement_type(:save => false) }
        post :create, :settlement_type => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested settlement_type" do
        SettlementType.should_receive(:find).with("37") { mock_settlement_type }
        mock_settlement_type.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :settlement_type => {'these' => 'params'}
      end

      it "assigns the requested settlement_type as @settlement_type" do
        SettlementType.stub(:find) { mock_settlement_type(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:settlement_type).should be(mock_settlement_type)
      end

      it "redirects to the settlement_type" do
        SettlementType.stub(:find) { mock_settlement_type(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(settlement_type_url(mock_settlement_type))
      end
    end

    describe "with invalid params" do
      it "assigns the settlement_type as @settlement_type" do
        SettlementType.stub(:find) { mock_settlement_type(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:settlement_type).should be(mock_settlement_type)
      end

      it "re-renders the 'edit' template" do
        SettlementType.stub(:find) { mock_settlement_type(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested settlement_type" do
      SettlementType.should_receive(:find).with("37") { mock_settlement_type }
      mock_settlement_type.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the settlement_types list" do
      SettlementType.stub(:find) { mock_settlement_type }
      delete :destroy, :id => "1"
      response.should redirect_to(settlement_types_url)
    end
  end

end
