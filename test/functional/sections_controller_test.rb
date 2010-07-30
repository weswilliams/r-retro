require 'test_helper'

class SectionsControllerTest < ActionController::TestCase
  setup do
    @section = sections(:section_1)
    @retrospective = retrospectives(:retrospective_1)
  end

  test "test should route sections of retrospective" do
    options = {:controller => 'sections', :action => 'index', :retrospective_id => '1'}
    assert_routing('retrospectives/1/sections', options)
  end

  test "should get index" do
    get :index, :retrospective_id => @retrospective.id
    assert_response :success
    assert_not_nil assigns(:sections)
    assert_select 'span.title', 1
  end

  test "should get new" do
    get :new, :retrospective_id => @retrospective.id
    assert_response :success
  end

#  test "should create section" do
#    assert_difference('Section.count') do
#
#      post :create, :retrospective_id => @retrospective, :section => @section.attributes
#    end
#
#    assert_redirected_to section_path(assigns(:section))
#  end
#
#  test "should show section" do
#    get :show, :id => @section.to_param
#    assert_response :success
#  end
#
#  test "should get edit" do
#    get :edit, :id => @section.to_param
#    assert_response :success
#  end
#
#  test "should update section" do
#    put :update, :id => @section.to_param, :section => @section.attributes
#    assert_redirected_to section_path(assigns(:section))
#  end
#
#  test "should destroy section" do
#    assert_difference('Section.count', -1) do
#      delete :destroy, :id => @section.to_param
#    end
#
#    assert_redirected_to sections_path
#  end
end
