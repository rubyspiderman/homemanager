require 'test_helper'

class ApplianceManufacturersControllerTest < ActionController::TestCase
  setup do
    @appliance_manufacturer = appliance_manufacturers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:appliance_manufacturers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create appliance_manufacturer" do
    assert_difference('ApplianceManufacturer.count') do
      post :create, appliance_manufacturer: {  }
    end

    assert_redirected_to appliance_manufacturer_path(assigns(:appliance_manufacturer))
  end

  test "should show appliance_manufacturer" do
    get :show, id: @appliance_manufacturer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @appliance_manufacturer
    assert_response :success
  end

  test "should update appliance_manufacturer" do
    put :update, id: @appliance_manufacturer, appliance_manufacturer: {  }
    assert_redirected_to appliance_manufacturer_path(assigns(:appliance_manufacturer))
  end

  test "should destroy appliance_manufacturer" do
    assert_difference('ApplianceManufacturer.count', -1) do
      delete :destroy, id: @appliance_manufacturer
    end

    assert_redirected_to appliance_manufacturers_path
  end
end
