require 'spec_helper'

describe ConversionsController do

  def mock_conversion(stubs={})
    (@mock_conversion ||= mock_model(Conversion).as_null_object).tap do |conversion|
      conversion.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all conversions as @conversions" do
      Conversion.stub(:all) { [mock_conversion] }
      get :index
      assigns(:conversions).should eq([mock_conversion])
    end
  end

  describe "GET show" do
    it "assigns the requested conversion as @conversion" do
      Conversion.stub(:find).with("37") { mock_conversion }
      get :show, :id => "37"
      assigns(:conversion).should be(mock_conversion)
    end
  end

  describe "GET new" do
    it "assigns a new conversion as @conversion" do
      Conversion.stub(:new) { mock_conversion }
      get :new
      assigns(:conversion).should be(mock_conversion)
    end
  end

  describe "GET edit" do
    it "assigns the requested conversion as @conversion" do
      Conversion.stub(:find).with("37") { mock_conversion }
      get :edit, :id => "37"
      assigns(:conversion).should be(mock_conversion)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created conversion as @conversion" do
        Conversion.stub(:new).with({'these' => 'params'}) { mock_conversion(:save => true) }
        post :create, :conversion => {'these' => 'params'}
        assigns(:conversion).should be(mock_conversion)
      end

      it "redirects to the created conversion" do
        Conversion.stub(:new) { mock_conversion(:save => true) }
        post :create, :conversion => {}
        response.should redirect_to(conversion_url(mock_conversion))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved conversion as @conversion" do
        Conversion.stub(:new).with({'these' => 'params'}) { mock_conversion(:save => false) }
        post :create, :conversion => {'these' => 'params'}
        assigns(:conversion).should be(mock_conversion)
      end

      it "re-renders the 'new' template" do
        Conversion.stub(:new) { mock_conversion(:save => false) }
        post :create, :conversion => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested conversion" do
        Conversion.should_receive(:find).with("37") { mock_conversion }
        mock_conversion.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :conversion => {'these' => 'params'}
      end

      it "assigns the requested conversion as @conversion" do
        Conversion.stub(:find) { mock_conversion(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:conversion).should be(mock_conversion)
      end

      it "redirects to the conversion" do
        Conversion.stub(:find) { mock_conversion(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(conversion_url(mock_conversion))
      end
    end

    describe "with invalid params" do
      it "assigns the conversion as @conversion" do
        Conversion.stub(:find) { mock_conversion(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:conversion).should be(mock_conversion)
      end

      it "re-renders the 'edit' template" do
        Conversion.stub(:find) { mock_conversion(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested conversion" do
      Conversion.should_receive(:find).with("37") { mock_conversion }
      mock_conversion.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the conversions list" do
      Conversion.stub(:find) { mock_conversion }
      delete :destroy, :id => "1"
      response.should redirect_to(conversions_url)
    end
  end

end
