require 'test_helper'

class ContractorTypesControllerTest < ActionController::TestCase
  setup do
    @contractor_type = contractor_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contractor_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contractor_type" do
    assert_difference('ContractorType.count') do
      post :create, contractor_type: {  }
    end

    assert_redirected_to contractor_type_path(assigns(:contractor_type))
  end

  test "should show contractor_type" do
    get :show, id: @contractor_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contractor_type
    assert_response :success
  end

  test "should update contractor_type" do
    put :update, id: @contractor_type, contractor_type: {  }
    assert_redirected_to contractor_type_path(assigns(:contractor_type))
  end

  test "should destroy contractor_type" do
    assert_difference('ContractorType.count', -1) do
      delete :destroy, id: @contractor_type
    end

    assert_redirected_to contractor_types_path
  end
end
