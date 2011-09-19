require 'test_helper'

class RestaurantcategoriesControllerTest < ActionController::TestCase
  setup do
    @restaurantcategory = restaurantcategories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:restaurantcategories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create restaurantcategory" do
    assert_difference('Restaurantcategory.count') do
      post :create, :restaurantcategory => @restaurantcategory.attributes
    end

    assert_redirected_to restaurantcategory_path(assigns(:restaurantcategory))
  end

  test "should show restaurantcategory" do
    get :show, :id => @restaurantcategory.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @restaurantcategory.to_param
    assert_response :success
  end

  test "should update restaurantcategory" do
    put :update, :id => @restaurantcategory.to_param, :restaurantcategory => @restaurantcategory.attributes
    assert_redirected_to restaurantcategory_path(assigns(:restaurantcategory))
  end

  test "should destroy restaurantcategory" do
    assert_difference('Restaurantcategory.count', -1) do
      delete :destroy, :id => @restaurantcategory.to_param
    end

    assert_redirected_to restaurantcategories_path
  end
end
