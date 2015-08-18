require 'test_helper'

class ConstructionTypesControllerTest < ActionController::TestCase
  setup do
    @construction_type = construction_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:construction_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create construction_type" do
    assert_difference('ConstructionType.count') do
      post :create, construction_type: {  }
    end

    assert_redirected_to construction_type_path(assigns(:construction_type))
  end

  test "should show construction_type" do
    get :show, id: @construction_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @construction_type
    assert_response :success
  end

  test "should update construction_type" do
    put :update, id: @construction_type, construction_type: {  }
    assert_redirected_to construction_type_path(assigns(:construction_type))
  end

  test "should destroy construction_type" do
    assert_difference('ConstructionType.count', -1) do
      delete :destroy, id: @construction_type
    end

    assert_redirected_to construction_types_path
  end
end
