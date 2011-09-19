require 'test_helper'

class EcrowsControllerTest < ActionController::TestCase
  setup do
    @ecrow = ecrows(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ecrows)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ecrow" do
    assert_difference('Ecrow.count') do
      post :create, :ecrow => @ecrow.attributes
    end

    assert_redirected_to ecrow_path(assigns(:ecrow))
  end

  test "should show ecrow" do
    get :show, :id => @ecrow.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @ecrow.to_param
    assert_response :success
  end

  test "should update ecrow" do
    put :update, :id => @ecrow.to_param, :ecrow => @ecrow.attributes
    assert_redirected_to ecrow_path(assigns(:ecrow))
  end

  test "should destroy ecrow" do
    assert_difference('Ecrow.count', -1) do
      delete :destroy, :id => @ecrow.to_param
    end

    assert_redirected_to ecrows_path
  end
end
