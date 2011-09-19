require 'test_helper'

class ReporttemplatesControllerTest < ActionController::TestCase
  setup do
    @reporttemplate = reporttemplates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reporttemplates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reporttemplate" do
    assert_difference('Reporttemplate.count') do
      post :create, :reporttemplate => @reporttemplate.attributes
    end

    assert_redirected_to reporttemplate_path(assigns(:reporttemplate))
  end

  test "should show reporttemplate" do
    get :show, :id => @reporttemplate.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @reporttemplate.to_param
    assert_response :success
  end

  test "should update reporttemplate" do
    put :update, :id => @reporttemplate.to_param, :reporttemplate => @reporttemplate.attributes
    assert_redirected_to reporttemplate_path(assigns(:reporttemplate))
  end

  test "should destroy reporttemplate" do
    assert_difference('Reporttemplate.count', -1) do
      delete :destroy, :id => @reporttemplate.to_param
    end

    assert_redirected_to reporttemplates_path
  end
end
