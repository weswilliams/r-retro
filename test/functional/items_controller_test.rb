require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  setup do
    @item = items(:item_1)
  end

  test "test should route items of sections of retrospective" do
    options = {:controller => 'items', :action => 'index', :retrospective_id => '1', :section_id => '2'}
    assert_routing('retrospectives/1/sections/2/items', options)
  end

  test "should get index" do
    get :index, {:retrospective_id => @item.section.retrospective.id, :section_id => @item.section.id}
    assert_response :success
    assert_not_nil assigns(:items)
  end

  test "should get new" do
    get :new, {:retrospective_id => @item.section.retrospective.id, :section_id => @item.section.id}
    assert_response :success
  end

  test "should create item" do
    assert_difference('Item.count') do
      post :create, :item => @item.attributes
    end

    assert_redirected_to item_path(assigns(:item))
  end

#  test "should show item" do
#    get :show, :id => @item.to_param
#    assert_response :success
#  end
#
#  test "should get edit" do
#    get :edit, :id => @item.to_param
#    assert_response :success
#  end
#
#  test "should update item" do
#    put :update, :id => @item.to_param, :item => @item.attributes
#    assert_redirected_to item_path(assigns(:item))
#  end
#
#  test "should destroy item" do
#    assert_difference('Item.count', -1) do
#      delete :destroy, :id => @item.to_param
#    end
#
#    assert_redirected_to items_path
#  end
end
