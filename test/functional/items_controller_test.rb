require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  setup do
    @item = items(:item_1)
  end

  test "ajax destroy should delete item" do
    assert_difference('Item.count', -1) do
      xhr :post, :destroy, :method => :delete, :retrospective_id => @item.section.retrospective.id, :section_id => @item.section.id, :id => @item.to_param
    end
    assert_response :success
    assert_select_rjs :remove, "section_item_#{@item.id}"
  end

  test "ajax add should create item" do
    section = sections(:section_1)
    assert_difference('Item.count') do
      xhr :post, :add, :controller => 'items', :retrospective_id => section.retrospective.id, :section_id => section.id, :value => 'blah'
    end
    assert_response :success
  end

  test "test should route items of sections of retrospective" do
    options = {:controller => 'items', :action => 'index', :retrospective_id => '1', :section_id => '2'}
    assert_routing('retrospectives/1/sections/2/items', options)
  end
  
  test "should create vote for item" do
    item = items :item_1
    assert_difference('item.item_votes.size') do
      xhr :post, :vote_for, :controller => 'items', :retrospective_id => item.section.retrospective.id, :section_id => item.section.id, :id => item.id
    end
    assert_response :success
  end

  test "should remove vote for item" do
    item = items :item_1
    assert_difference('item.item_votes.size', -1) do
      xhr :post, :remove_vote, :controller => 'items', :retrospective_id => item.section.retrospective.id, :section_id => item.section.id, :id => item.id
    end
    assert_response :success
  end

  test "test should route add item of sections of retrospective" do
    options = {:controller => 'items', :action => 'add', :retrospective_id => '1', :section_id => '2'}
    assert_routing({:method => 'post', :path => 'retrospectives/1/sections/2/items/add'}, options)
  end

  test "should get index" do
    get :index, :retrospective_id => @item.section.retrospective.id, :section_id => @item.section.id
    assert_response :success
    assert_not_nil assigns(:items)
  end

  test "should get new" do
    get :new, :retrospective_id => @item.section.retrospective.id, :section_id => @item.section.id
    assert_response :success
  end

  test "should create item" do
    retrospective_id = @item.section.retrospective.to_param
    section_id = @item.section.to_param
    assert_difference('Item.count') do
      post :create, :retrospective_id => retrospective_id, :section_id => section_id, :item => @item.attributes
    end

    assert_redirected_to retrospective_path(retrospective_id)
  end

  test "should show item" do
    get :show, :retrospective_id => @item.section.retrospective.id, :section_id => @item.section.id, :id => @item.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :retrospective_id => @item.section.retrospective.id, :section_id => @item.section.id, :id => @item.to_param
    assert_response :success
  end

  test "should update item" do
    retrospective_id = @item.section.retrospective.to_param
    section_id = @item.section.id
    put :update, :retrospective_id => retrospective_id, :section_id => section_id, :id => @item.to_param, :item => @item.attributes
    assert_redirected_to retrospective_path(retrospective_id)
  end

  test "should destroy item" do
    assert_difference('Item.count', -1) do
      delete :destroy, :retrospective_id => @item.section.retrospective.id, :section_id => @item.section.id, :id => @item.to_param
    end

    assert_redirected_to retrospective_path(@item.section.retrospective)
  end

  test "should remove group from item" do
    item = items :item_1
    item.group = groups :group_1
    item.save
    xhr :post, :remove_from_group, :controller => 'items', :retrospective_id => item.section.retrospective.id, :section_id => item.section.id, :id => item.id
  end
end
