require 'test_helper'

class MaintenanceCyclesControllerTest < ActionController::TestCase
  setup do
    @maintenance_cycle = maintenance_cycles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:maintenance_cycles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create maintenance_cycle" do
    assert_difference('MaintenanceCycle.count') do
      post :create, maintenance_cycle: {  }
    end

    assert_redirected_to maintenance_cycle_path(assigns(:maintenance_cycle))
  end

  test "should show maintenance_cycle" do
    get :show, id: @maintenance_cycle
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @maintenance_cycle
    assert_response :success
  end

  test "should update maintenance_cycle" do
    put :update, id: @maintenance_cycle, maintenance_cycle: {  }
    assert_redirected_to maintenance_cycle_path(assigns(:maintenance_cycle))
  end

  test "should destroy maintenance_cycle" do
    assert_difference('MaintenanceCycle.count', -1) do
      delete :destroy, id: @maintenance_cycle
    end

    assert_redirected_to maintenance_cycles_path
  end
end
