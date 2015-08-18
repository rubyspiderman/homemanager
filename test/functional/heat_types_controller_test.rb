require 'test_helper'

class HeatTypesControllerTest < ActionController::TestCase
  setup do
    @heat_type = heat_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:heat_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create heat_type" do
    assert_difference('HeatType.count') do
      post :create, heat_type: {  }
    end

    assert_redirected_to heat_type_path(assigns(:heat_type))
  end

  test "should show heat_type" do
    get :show, id: @heat_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @heat_type
    assert_response :success
  end

  test "should update heat_type" do
    put :update, id: @heat_type, heat_type: {  }
    assert_redirected_to heat_type_path(assigns(:heat_type))
  end

  test "should destroy heat_type" do
    assert_difference('HeatType.count', -1) do
      delete :destroy, id: @heat_type
    end

    assert_redirected_to heat_types_path
  end
end
