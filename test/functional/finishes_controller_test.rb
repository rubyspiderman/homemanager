require 'test_helper'

class FinishesControllerTest < ActionController::TestCase
  setup do
    @finish = finishes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:finishes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create finish" do
    assert_difference('Finish.count') do
      post :create, finish: {  }
    end

    assert_redirected_to finish_path(assigns(:finish))
  end

  test "should show finish" do
    get :show, id: @finish
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @finish
    assert_response :success
  end

  test "should update finish" do
    put :update, id: @finish, finish: {  }
    assert_redirected_to finish_path(assigns(:finish))
  end

  test "should destroy finish" do
    assert_difference('Finish.count', -1) do
      delete :destroy, id: @finish
    end

    assert_redirected_to finishes_path
  end
end
