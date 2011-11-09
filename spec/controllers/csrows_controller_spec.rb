require 'spec_helper'

describe CsrowsController do
  include Devise::TestHelpers

  before do
    @user = User.create!(:email => 'test@appsource.com', :password => 'password')
    sign_in @user
  end

  def mock_csrow(stubs={})
    (@mock_csrow ||= mock_model(Csrow).as_null_object).tap do |csrow|
      csrow.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all csrows as @csrows" do
      Csrow.stub(:all) { [mock_csrow] }
      get :index
      assigns(:csrows).should eq([mock_csrow])
    end
  end

  describe "GET show" do
    it "assigns the requested csrow as @csrow" do
      Csrow.stub(:find).with("37") { mock_csrow }
      get :show, :id => "37"
      assigns(:csrow).should be(mock_csrow)
    end
  end

  describe "GET new" do
    it "assigns a new csrow as @csrow" do
      Csrow.stub(:new) { mock_csrow }
      get :new
      assigns(:csrow).should be(mock_csrow)
    end
  end

  describe "GET edit" do
    it "assigns the requested csrow as @csrow" do
      Csrow.stub(:find).with("37") { mock_csrow }
      get :edit, :id => "37"
      assigns(:csrow).should be(mock_csrow)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created csrow as @csrow" do
        Csrow.stub(:new).with({'these' => 'params'}) { mock_csrow(:save => true) }
        post :create, :csrow => {'these' => 'params'}
        assigns(:csrow).should be(mock_csrow)
      end

      it "redirects to the created csrow" do
        Csrow.stub(:new) { mock_csrow(:save => true) }
        post :create, :csrow => {}
        response.should redirect_to(csrow_url(mock_csrow))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved csrow as @csrow" do
        Csrow.stub(:new).with({'these' => 'params'}) { mock_csrow(:save => false) }
        post :create, :csrow => {'these' => 'params'}
        assigns(:csrow).should be(mock_csrow)
      end

      it "re-renders the 'new' template" do
        Csrow.stub(:new) { mock_csrow(:save => false) }
        post :create, :csrow => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested csrow" do
        Csrow.should_receive(:find).with("37") { mock_csrow }
        mock_csrow.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :csrow => {'these' => 'params'}
      end

      it "assigns the requested csrow as @csrow" do
        Csrow.stub(:find) { mock_csrow(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:csrow).should be(mock_csrow)
      end

      it "redirects to the csrow" do
        Csrow.stub(:find) { mock_csrow(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(csrow_url(mock_csrow))
      end
    end

    describe "with invalid params" do
      it "assigns the csrow as @csrow" do
        Csrow.stub(:find) { mock_csrow(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:csrow).should be(mock_csrow)
      end

      it "re-renders the 'edit' template" do
        Csrow.stub(:find) { mock_csrow(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested csrow" do
      Csrow.should_receive(:find).with("37") { mock_csrow }
      mock_csrow.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the csrows list" do
      Csrow.stub(:find) { mock_csrow }
      delete :destroy, :id => "1"
      response.should redirect_to(csrows_url)
    end
  end

end
