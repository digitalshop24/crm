require 'test_helper'

class SubscpecialitiesControllerTest < ActionController::TestCase
  setup do
    @subscpeciality = subscpecialities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subscpecialities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subscpeciality" do
    assert_difference('Subscpeciality.count') do
      post :create, subscpeciality: {  }
    end

    assert_redirected_to subscpeciality_path(assigns(:subscpeciality))
  end

  test "should show subscpeciality" do
    get :show, id: @subscpeciality
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @subscpeciality
    assert_response :success
  end

  test "should update subscpeciality" do
    patch :update, id: @subscpeciality, subscpeciality: {  }
    assert_redirected_to subscpeciality_path(assigns(:subscpeciality))
  end

  test "should destroy subscpeciality" do
    assert_difference('Subscpeciality.count', -1) do
      delete :destroy, id: @subscpeciality
    end

    assert_redirected_to subscpecialities_path
  end
end
