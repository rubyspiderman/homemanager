require 'test_helper'

class AreaTypesControllerTest < ActionController::TestCase
  setup do
    @area_type = area_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:area_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create area_type" do
    assert_difference('AreaType.count') do
      post :create, area_type: {  }
    end

    assert_redirected_to area_type_path(assigns(:area_type))
  end

  test "should show area_type" do
    get :show, id: @area_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @area_type
    assert_response :success
  end

  test "should update area_type" do
    put :update, id: @area_type, area_type: {  }
    assert_redirected_to area_type_path(assigns(:area_type))
  end

  test "should destroy area_type" do
    assert_difference('AreaType.count', -1) do
      delete :destroy, id: @area_type
    end

    assert_redirected_to area_types_path
  end
end
