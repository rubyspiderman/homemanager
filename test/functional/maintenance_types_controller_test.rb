require 'test_helper'

class MaintenanceTypesControllerTest < ActionController::TestCase
  setup do
    @maintenance_type = maintenance_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:maintenance_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create maintenance_type" do
    assert_difference('MaintenanceType.count') do
      post :create, maintenance_type: {  }
    end

    assert_redirected_to maintenance_type_path(assigns(:maintenance_type))
  end

  test "should show maintenance_type" do
    get :show, id: @maintenance_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @maintenance_type
    assert_response :success
  end

  test "should update maintenance_type" do
    put :update, id: @maintenance_type, maintenance_type: {  }
    assert_redirected_to maintenance_type_path(assigns(:maintenance_type))
  end

  test "should destroy maintenance_type" do
    assert_difference('MaintenanceType.count', -1) do
      delete :destroy, id: @maintenance_type
    end

    assert_redirected_to maintenance_types_path
  end
end
