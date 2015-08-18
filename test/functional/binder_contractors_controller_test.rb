require 'test_helper'

class BinderContractorsControllerTest < ActionController::TestCase
  setup do
    @binder_contractor = binder_contractors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:binder_contractors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create binder_contractor" do
    assert_difference('BinderContractor.count') do
      post :create, binder_contractor: {  }
    end

    assert_redirected_to binder_contractor_path(assigns(:binder_contractor))
  end

  test "should show binder_contractor" do
    get :show, id: @binder_contractor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @binder_contractor
    assert_response :success
  end

  test "should update binder_contractor" do
    put :update, id: @binder_contractor, binder_contractor: {  }
    assert_redirected_to binder_contractor_path(assigns(:binder_contractor))
  end

  test "should destroy binder_contractor" do
    assert_difference('BinderContractor.count', -1) do
      delete :destroy, id: @binder_contractor
    end

    assert_redirected_to binder_contractors_path
  end
end
