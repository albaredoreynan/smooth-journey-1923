require 'spec_helper'

describe SubcategoriesController do

  def mock_subcategory(stubs={})
    (@mock_subcategory ||= mock_model(Subcategory).as_null_object).tap do |subcategory|
      subcategory.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all subcategories as @subcategories" do
      Subcategory.stub(:all) { [mock_subcategory] }
      get :index
      assigns(:subcategories).should eq([mock_subcategory])
    end
  end

  describe "GET show" do
    it "assigns the requested subcategory as @subcategory" do
      Subcategory.stub(:find).with("37") { mock_subcategory }
      get :show, :id => "37"
      assigns(:subcategory).should be(mock_subcategory)
    end
  end

  describe "GET new" do
    it "assigns a new subcategory as @subcategory" do
      Subcategory.stub(:new) { mock_subcategory }
      get :new
      assigns(:subcategory).should be(mock_subcategory)
    end
  end

  describe "GET edit" do
    it "assigns the requested subcategory as @subcategory" do
      Subcategory.stub(:find).with("37") { mock_subcategory }
      get :edit, :id => "37"
      assigns(:subcategory).should be(mock_subcategory)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created subcategory as @subcategory" do
        Subcategory.stub(:new).with({'these' => 'params'}) { mock_subcategory(:save => true) }
        post :create, :subcategory => {'these' => 'params'}
        assigns(:subcategory).should be(mock_subcategory)
      end

      it "redirects to the created subcategory" do
        Subcategory.stub(:new) { mock_subcategory(:save => true) }
        post :create, :subcategory => {}
        response.should redirect_to(subcategory_url(mock_subcategory))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved subcategory as @subcategory" do
        Subcategory.stub(:new).with({'these' => 'params'}) { mock_subcategory(:save => false) }
        post :create, :subcategory => {'these' => 'params'}
        assigns(:subcategory).should be(mock_subcategory)
      end

      it "re-renders the 'new' template" do
        Subcategory.stub(:new) { mock_subcategory(:save => false) }
        post :create, :subcategory => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested subcategory" do
        Subcategory.should_receive(:find).with("37") { mock_subcategory }
        mock_subcategory.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :subcategory => {'these' => 'params'}
      end

      it "assigns the requested subcategory as @subcategory" do
        Subcategory.stub(:find) { mock_subcategory(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:subcategory).should be(mock_subcategory)
      end

      it "redirects to the subcategory" do
        Subcategory.stub(:find) { mock_subcategory(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(subcategory_url(mock_subcategory))
      end
    end

    describe "with invalid params" do
      it "assigns the subcategory as @subcategory" do
        Subcategory.stub(:find) { mock_subcategory(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:subcategory).should be(mock_subcategory)
      end

      it "re-renders the 'edit' template" do
        Subcategory.stub(:find) { mock_subcategory(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested subcategory" do
      Subcategory.should_receive(:find).with("37") { mock_subcategory }
      mock_subcategory.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the subcategories list" do
      Subcategory.stub(:find) { mock_subcategory }
      delete :destroy, :id => "1"
      response.should redirect_to(subcategories_url)
    end
  end

end
