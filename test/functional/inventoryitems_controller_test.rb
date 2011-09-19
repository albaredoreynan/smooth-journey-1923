require 'test_helper'

class InventoryitemsControllerTest < ActionController::TestCase
  setup do
    @inventoryitem = inventoryitems(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inventoryitems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inventoryitem" do
    assert_difference('Inventoryitem.count') do
      post :create, :inventoryitem => @inventoryitem.attributes
    end

    assert_redirected_to inventoryitem_path(assigns(:inventoryitem))
  end

  test "should show inventoryitem" do
    get :show, :id => @inventoryitem.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @inventoryitem.to_param
    assert_response :success
  end

  test "should update inventoryitem" do
    put :update, :id => @inventoryitem.to_param, :inventoryitem => @inventoryitem.attributes
    assert_redirected_to inventoryitem_path(assigns(:inventoryitem))
  end

  test "should destroy inventoryitem" do
    assert_difference('Inventoryitem.count', -1) do
      delete :destroy, :id => @inventoryitem.to_param
    end

    assert_redirected_to inventoryitems_path
  end
end
