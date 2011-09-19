require 'test_helper'

class PurchaseitemsControllerTest < ActionController::TestCase
  setup do
    @purchaseitem = purchaseitems(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:purchaseitems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create purchaseitem" do
    assert_difference('Purchaseitem.count') do
      post :create, :purchaseitem => @purchaseitem.attributes
    end

    assert_redirected_to purchaseitem_path(assigns(:purchaseitem))
  end

  test "should show purchaseitem" do
    get :show, :id => @purchaseitem.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @purchaseitem.to_param
    assert_response :success
  end

  test "should update purchaseitem" do
    put :update, :id => @purchaseitem.to_param, :purchaseitem => @purchaseitem.attributes
    assert_redirected_to purchaseitem_path(assigns(:purchaseitem))
  end

  test "should destroy purchaseitem" do
    assert_difference('Purchaseitem.count', -1) do
      delete :destroy, :id => @purchaseitem.to_param
    end

    assert_redirected_to purchaseitems_path
  end
end
