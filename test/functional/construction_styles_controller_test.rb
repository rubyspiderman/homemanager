require 'test_helper'

class ConstructionStylesControllerTest < ActionController::TestCase
  setup do
    @construction_style = construction_styles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:construction_styles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create construction_style" do
    assert_difference('ConstructionStyle.count') do
      post :create, construction_style: {  }
    end

    assert_redirected_to construction_style_path(assigns(:construction_style))
  end

  test "should show construction_style" do
    get :show, id: @construction_style
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @construction_style
    assert_response :success
  end

  test "should update construction_style" do
    put :update, id: @construction_style, construction_style: {  }
    assert_redirected_to construction_style_path(assigns(:construction_style))
  end

  test "should destroy construction_style" do
    assert_difference('ConstructionStyle.count', -1) do
      delete :destroy, id: @construction_style
    end

    assert_redirected_to construction_styles_path
  end
end
