require 'test_helper'

class ContractorAbilitiesControllerTest < ActionController::TestCase
  setup do
    @contractor_ability = contractor_abilities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contractor_abilities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contractor_ability" do
    assert_difference('ContractorAbility.count') do
      post :create, contractor_ability: {  }
    end

    assert_redirected_to contractor_ability_path(assigns(:contractor_ability))
  end

  test "should show contractor_ability" do
    get :show, id: @contractor_ability
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contractor_ability
    assert_response :success
  end

  test "should update contractor_ability" do
    put :update, id: @contractor_ability, contractor_ability: {  }
    assert_redirected_to contractor_ability_path(assigns(:contractor_ability))
  end

  test "should destroy contractor_ability" do
    assert_difference('ContractorAbility.count', -1) do
      delete :destroy, id: @contractor_ability
    end

    assert_redirected_to contractor_abilities_path
  end
end
