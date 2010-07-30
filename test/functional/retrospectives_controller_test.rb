require 'test_helper'

class RetrospectivesControllerTest < ActionController::TestCase
  setup do
    @retrospective = retrospectives(:retrospective_1)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:retrospectives)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create retrospective" do
    assert_difference('Retrospective.count') do
      post :create, :retrospective => @retrospective.attributes
    end

    assert_redirected_to retrospective_path(assigns(:retrospective))
  end

  test "should show retrospective" do
    get :show, :id => @retrospective.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @retrospective.to_param
    assert_response :success
  end

  test "should update retrospective" do
    put :update, :id => @retrospective.to_param, :retrospective => @retrospective.attributes
    assert_redirected_to retrospective_path(assigns(:retrospective))
  end

  test "should destroy retrospective" do
    assert_difference('Retrospective.count', -1) do
      delete :destroy, :id => @retrospective.to_param
    end

    assert_redirected_to retrospectives_path
  end
end
