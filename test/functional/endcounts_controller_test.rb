require 'test_helper'

class EndcountsControllerTest < ActionController::TestCase
  setup do
    @endcount = endcounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:endcounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create endcount" do
    assert_difference('Endcount.count') do
      post :create, :endcount => @endcount.attributes
    end

    assert_redirected_to endcount_path(assigns(:endcount))
  end

  test "should show endcount" do
    get :show, :id => @endcount.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @endcount.to_param
    assert_response :success
  end

  test "should update endcount" do
    put :update, :id => @endcount.to_param, :endcount => @endcount.attributes
    assert_redirected_to endcount_path(assigns(:endcount))
  end

  test "should destroy endcount" do
    assert_difference('Endcount.count', -1) do
      delete :destroy, :id => @endcount.to_param
    end

    assert_redirected_to endcounts_path
  end
end
