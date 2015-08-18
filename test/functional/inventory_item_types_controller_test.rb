require 'test_helper'

class InventoryItemTypesControllerTest < ActionController::TestCase
  setup do
    @inventory_item_type = inventory_item_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inventory_item_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inventory_item_type" do
    assert_difference('InventoryItemType.count') do
      post :create, inventory_item_type: {  }
    end

    assert_redirected_to inventory_item_type_path(assigns(:inventory_item_type))
  end

  test "should show inventory_item_type" do
    get :show, id: @inventory_item_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inventory_item_type
    assert_response :success
  end

  test "should update inventory_item_type" do
    put :update, id: @inventory_item_type, inventory_item_type: {  }
    assert_redirected_to inventory_item_type_path(assigns(:inventory_item_type))
  end

  test "should destroy inventory_item_type" do
    assert_difference('InventoryItemType.count', -1) do
      delete :destroy, id: @inventory_item_type
    end

    assert_redirected_to inventory_item_types_path
  end
end
