require 'test_helper'

class CategorysalesControllerTest < ActionController::TestCase
  setup do
    @categorysale = categorysales(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categorysales)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create categorysale" do
    assert_difference('Categorysale.count') do
      post :create, :categorysale => @categorysale.attributes
    end

    assert_redirected_to categorysale_path(assigns(:categorysale))
  end

  test "should show categorysale" do
    get :show, :id => @categorysale.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @categorysale.to_param
    assert_response :success
  end

  test "should update categorysale" do
    put :update, :id => @categorysale.to_param, :categorysale => @categorysale.attributes
    assert_redirected_to categorysale_path(assigns(:categorysale))
  end

  test "should destroy categorysale" do
    assert_difference('Categorysale.count', -1) do
      delete :destroy, :id => @categorysale.to_param
    end

    assert_redirected_to categorysales_path
  end
end
