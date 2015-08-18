require 'test_helper'

class FinishModelsControllerTest < ActionController::TestCase
  setup do
    @finish_model = finish_models(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:finish_models)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create finish_model" do
    assert_difference('FinishModel.count') do
      post :create, finish_model: {  }
    end

    assert_redirected_to finish_model_path(assigns(:finish_model))
  end

  test "should show finish_model" do
    get :show, id: @finish_model
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @finish_model
    assert_response :success
  end

  test "should update finish_model" do
    put :update, id: @finish_model, finish_model: {  }
    assert_redirected_to finish_model_path(assigns(:finish_model))
  end

  test "should destroy finish_model" do
    assert_difference('FinishModel.count', -1) do
      delete :destroy, id: @finish_model
    end

    assert_redirected_to finish_models_path
  end
end
