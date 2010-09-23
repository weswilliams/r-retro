require 'test_helper'

class GroupsControllerTest < ActionController::TestCase

  test "test should route groups of retrospective" do
    options = {:controller => 'groups', :action => 'add', :retrospective_id => '1'}
    assert_routing({:method => 'post', :path => 'retrospectives/1/groups/add'}, options)
  end

  test "ajax add should create group" do
    retrospective = retrospectives(:retrospective_1)
    assert_difference('Group.count') do
      xhr :post, :add, :controller => 'groups', :retrospective_id => retrospective.id, :title => "new group 1"
    end
    assert_response :success
  end

  test "ajax add should create simple title if one is not passed in parameters" do
    retrospective = retrospectives(:retrospective_1)
    assert_difference('Group.count') do
      xhr :post, :add, :controller => 'groups', :retrospective_id => retrospective.id
    end
    assert_response :success
    assert_equal "Group#{Retrospective.find(:all).size}", assigns("group").title
  end

  test "should be able to update title via ajax" do
    group = groups(:group_1)
    title = "updated title"
    xhr :post, :update_title, :controller => 'groups', :id => group.id, :retrospective_id => group.retrospective_id, :title => title
    assert_response :success
    assert_equal title, assigns("group").title
  end

end