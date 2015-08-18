require 'test_helper'

class PaintTypesControllerTest < ActionController::TestCase
  setup do
    @paint_type = paint_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:paint_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create paint_type" do
    assert_difference('PaintType.count') do
      post :create, paint_type: {  }
    end

    assert_redirected_to paint_type_path(assigns(:paint_type))
  end

  test "should show paint_type" do
    get :show, id: @paint_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @paint_type
    assert_response :success
  end

  test "should update paint_type" do
    put :update, id: @paint_type, paint_type: {  }
    assert_redirected_to paint_type_path(assigns(:paint_type))
  end

  test "should destroy paint_type" do
    assert_difference('PaintType.count', -1) do
      delete :destroy, id: @paint_type
    end

    assert_redirected_to paint_types_path
  end
end
