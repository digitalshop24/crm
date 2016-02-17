require 'test_helper'

class SeosControllerTest < ActionController::TestCase
  setup do
    @seo = seos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:seos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create seo" do
    assert_difference('Seo.count') do
      post :create, seo: { code_title: @seo.code_title, description: @seo.description, name: @seo.name, title: @seo.title }
    end

    assert_redirected_to seo_path(assigns(:seo))
  end

  test "should show seo" do
    get :show, id: @seo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @seo
    assert_response :success
  end

  test "should update seo" do
    patch :update, id: @seo, seo: { code_title: @seo.code_title, description: @seo.description, name: @seo.name, title: @seo.title }
    assert_redirected_to seo_path(assigns(:seo))
  end

  test "should destroy seo" do
    assert_difference('Seo.count', -1) do
      delete :destroy, id: @seo
    end

    assert_redirected_to seos_path
  end
end
