require 'test_helper'

class HeatSourcesControllerTest < ActionController::TestCase
  setup do
    @heat_source = heat_sources(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:heat_sources)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create heat_source" do
    assert_difference('HeatSource.count') do
      post :create, heat_source: {  }
    end

    assert_redirected_to heat_source_path(assigns(:heat_source))
  end

  test "should show heat_source" do
    get :show, id: @heat_source
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @heat_source
    assert_response :success
  end

  test "should update heat_source" do
    put :update, id: @heat_source, heat_source: {  }
    assert_redirected_to heat_source_path(assigns(:heat_source))
  end

  test "should destroy heat_source" do
    assert_difference('HeatSource.count', -1) do
      delete :destroy, id: @heat_source
    end

    assert_redirected_to heat_sources_path
  end
end
