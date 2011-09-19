require 'spec_helper'

describe SsrowsController do

  def mock_ssrow(stubs={})
    (@mock_ssrow ||= mock_model(Ssrow).as_null_object).tap do |ssrow|
      ssrow.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all ssrows as @ssrows" do
      Ssrow.stub(:all) { [mock_ssrow] }
      get :index
      assigns(:ssrows).should eq([mock_ssrow])
    end
  end

  describe "GET show" do
    it "assigns the requested ssrow as @ssrow" do
      Ssrow.stub(:find).with("37") { mock_ssrow }
      get :show, :id => "37"
      assigns(:ssrow).should be(mock_ssrow)
    end
  end

  describe "GET new" do
    it "assigns a new ssrow as @ssrow" do
      Ssrow.stub(:new) { mock_ssrow }
      get :new
      assigns(:ssrow).should be(mock_ssrow)
    end
  end

  describe "GET edit" do
    it "assigns the requested ssrow as @ssrow" do
      Ssrow.stub(:find).with("37") { mock_ssrow }
      get :edit, :id => "37"
      assigns(:ssrow).should be(mock_ssrow)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created ssrow as @ssrow" do
        Ssrow.stub(:new).with({'these' => 'params'}) { mock_ssrow(:save => true) }
        post :create, :ssrow => {'these' => 'params'}
        assigns(:ssrow).should be(mock_ssrow)
      end

      it "redirects to the created ssrow" do
        Ssrow.stub(:new) { mock_ssrow(:save => true) }
        post :create, :ssrow => {}
        response.should redirect_to(ssrow_url(mock_ssrow))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved ssrow as @ssrow" do
        Ssrow.stub(:new).with({'these' => 'params'}) { mock_ssrow(:save => false) }
        post :create, :ssrow => {'these' => 'params'}
        assigns(:ssrow).should be(mock_ssrow)
      end

      it "re-renders the 'new' template" do
        Ssrow.stub(:new) { mock_ssrow(:save => false) }
        post :create, :ssrow => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested ssrow" do
        Ssrow.should_receive(:find).with("37") { mock_ssrow }
        mock_ssrow.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :ssrow => {'these' => 'params'}
      end

      it "assigns the requested ssrow as @ssrow" do
        Ssrow.stub(:find) { mock_ssrow(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:ssrow).should be(mock_ssrow)
      end

      it "redirects to the ssrow" do
        Ssrow.stub(:find) { mock_ssrow(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(ssrow_url(mock_ssrow))
      end
    end

    describe "with invalid params" do
      it "assigns the ssrow as @ssrow" do
        Ssrow.stub(:find) { mock_ssrow(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:ssrow).should be(mock_ssrow)
      end

      it "re-renders the 'edit' template" do
        Ssrow.stub(:find) { mock_ssrow(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested ssrow" do
      Ssrow.should_receive(:find).with("37") { mock_ssrow }
      mock_ssrow.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the ssrows list" do
      Ssrow.stub(:find) { mock_ssrow }
      delete :destroy, :id => "1"
      response.should redirect_to(ssrows_url)
    end
  end

end
