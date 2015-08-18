require 'test_helper'

class PaintManufacturersControllerTest < ActionController::TestCase
  setup do
    @paint_manufacturer = paint_manufacturers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:paint_manufacturers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create paint_manufacturer" do
    assert_difference('PaintManufacturer.count') do
      post :create, paint_manufacturer: {  }
    end

    assert_redirected_to paint_manufacturer_path(assigns(:paint_manufacturer))
  end

  test "should show paint_manufacturer" do
    get :show, id: @paint_manufacturer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @paint_manufacturer
    assert_response :success
  end

  test "should update paint_manufacturer" do
    put :update, id: @paint_manufacturer, paint_manufacturer: {  }
    assert_redirected_to paint_manufacturer_path(assigns(:paint_manufacturer))
  end

  test "should destroy paint_manufacturer" do
    assert_difference('PaintManufacturer.count', -1) do
      delete :destroy, id: @paint_manufacturer
    end

    assert_redirected_to paint_manufacturers_path
  end
end
