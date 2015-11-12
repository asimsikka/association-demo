require 'test_helper'

class ProjxesControllerTest < ActionController::TestCase
  setup do
    @projx = projxes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projxes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create projx" do
    assert_difference('Projx.count') do
      post :create, projx: { content: @projx.content, title: @projx.title }
    end

    assert_redirected_to projx_path(assigns(:projx))
  end

  test "should show projx" do
    get :show, id: @projx
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @projx
    assert_response :success
  end

  test "should update projx" do
    patch :update, id: @projx, projx: { content: @projx.content, title: @projx.title }
    assert_redirected_to projx_path(assigns(:projx))
  end

  test "should destroy projx" do
    assert_difference('Projx.count', -1) do
      delete :destroy, id: @projx
    end

    assert_redirected_to projxes_path
  end
end
