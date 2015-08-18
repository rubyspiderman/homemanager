require 'test_helper'

class MaintenanceEventsControllerTest < ActionController::TestCase
  setup do
    @maintenance_event = maintenance_events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:maintenance_events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create maintenance_event" do
    assert_difference('MaintenanceEvent.count') do
      post :create, maintenance_event: {  }
    end

    assert_redirected_to maintenance_event_path(assigns(:maintenance_event))
  end

  test "should show maintenance_event" do
    get :show, id: @maintenance_event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @maintenance_event
    assert_response :success
  end

  test "should update maintenance_event" do
    put :update, id: @maintenance_event, maintenance_event: {  }
    assert_redirected_to maintenance_event_path(assigns(:maintenance_event))
  end

  test "should destroy maintenance_event" do
    assert_difference('MaintenanceEvent.count', -1) do
      delete :destroy, id: @maintenance_event
    end

    assert_redirected_to maintenance_events_path
  end
end
