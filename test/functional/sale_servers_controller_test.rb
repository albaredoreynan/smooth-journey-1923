require 'test_helper'

class SaleServersControllerTest < ActionController::TestCase
  setup do
    @sale_server = sale_servers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sale_servers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sale_server" do
    assert_difference('SaleServer.count') do
      post :create, sale_server: @sale_server.attributes
    end

    assert_redirected_to sale_server_path(assigns(:sale_server))
  end

  test "should show sale_server" do
    get :show, id: @sale_server
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sale_server
    assert_response :success
  end

  test "should update sale_server" do
    put :update, id: @sale_server, sale_server: @sale_server.attributes
    assert_redirected_to sale_server_path(assigns(:sale_server))
  end

  test "should destroy sale_server" do
    assert_difference('SaleServer.count', -1) do
      delete :destroy, id: @sale_server
    end

    assert_redirected_to sale_servers_path
  end
end
