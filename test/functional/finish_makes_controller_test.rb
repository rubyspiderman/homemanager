require 'test_helper'

class FinishMakesControllerTest < ActionController::TestCase
  setup do
    @finish_make = finish_makes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:finish_makes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create finish_make" do
    assert_difference('FinishMake.count') do
      post :create, finish_make: {  }
    end

    assert_redirected_to finish_make_path(assigns(:finish_make))
  end

  test "should show finish_make" do
    get :show, id: @finish_make
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @finish_make
    assert_response :success
  end

  test "should update finish_make" do
    put :update, id: @finish_make, finish_make: {  }
    assert_redirected_to finish_make_path(assigns(:finish_make))
  end

  test "should destroy finish_make" do
    assert_difference('FinishMake.count', -1) do
      delete :destroy, id: @finish_make
    end

    assert_redirected_to finish_makes_path
  end
end
