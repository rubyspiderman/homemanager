require 'test_helper'

class ApplianceModelsControllerTest < ActionController::TestCase
  setup do
    @appliance_model = appliance_models(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:appliance_models)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create appliance_model" do
    assert_difference('ApplianceModel.count') do
      post :create, appliance_model: {  }
    end

    assert_redirected_to appliance_model_path(assigns(:appliance_model))
  end

  test "should show appliance_model" do
    get :show, id: @appliance_model
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @appliance_model
    assert_response :success
  end

  test "should update appliance_model" do
    put :update, id: @appliance_model, appliance_model: {  }
    assert_redirected_to appliance_model_path(assigns(:appliance_model))
  end

  test "should destroy appliance_model" do
    assert_difference('ApplianceModel.count', -1) do
      delete :destroy, id: @appliance_model
    end

    assert_redirected_to appliance_models_path
  end
end
