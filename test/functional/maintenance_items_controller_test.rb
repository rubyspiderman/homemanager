require 'test_helper'

class MaintenanceItemsControllerTest < ActionController::TestCase
  setup do
    @maintenance_item = maintenance_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:maintenance_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create maintenance_item" do
    assert_difference('MaintenanceItem.count') do
      post :create, maintenance_item: {  }
    end

    assert_redirected_to maintenance_item_path(assigns(:maintenance_item))
  end

  test "should show maintenance_item" do
    get :show, id: @maintenance_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @maintenance_item
    assert_response :success
  end

  test "should update maintenance_item" do
    put :update, id: @maintenance_item, maintenance_item: {  }
    assert_redirected_to maintenance_item_path(assigns(:maintenance_item))
  end

  test "should destroy maintenance_item" do
    assert_difference('MaintenanceItem.count', -1) do
      delete :destroy, id: @maintenance_item
    end

    assert_redirected_to maintenance_items_path
  end
end
