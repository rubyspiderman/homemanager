require 'test_helper'

class ApplianceTypesControllerTest < ActionController::TestCase
  setup do
    @appliance_type = appliance_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:appliance_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create appliance_type" do
    assert_difference('ApplianceType.count') do
      post :create, appliance_type: {  }
    end

    assert_redirected_to appliance_type_path(assigns(:appliance_type))
  end

  test "should show appliance_type" do
    get :show, id: @appliance_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @appliance_type
    assert_response :success
  end

  test "should update appliance_type" do
    put :update, id: @appliance_type, appliance_type: {  }
    assert_redirected_to appliance_type_path(assigns(:appliance_type))
  end

  test "should destroy appliance_type" do
    assert_difference('ApplianceType.count', -1) do
      delete :destroy, id: @appliance_type
    end

    assert_redirected_to appliance_types_path
  end
end
