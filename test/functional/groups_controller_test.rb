require 'test_helper'

class GroupsControllerTest < ActionController::TestCase

  test "ajax add should create group" do
    retrospective = retrospectives(:retrospective_1)
    assert_difference('Group.count') do
      xhr :post, :add, :controller => 'groups', :retrospective_id => retrospective.id, :title => "new group 1"
    end
    assert_response :success
  end

  test "add should create simple name if one is not passed in parameters" do
    retrospective = retrospectives(:retrospective_1)
    assert_difference('Group.count') do
      xhr :post, :add, :controller => 'groups', :retrospective_id => retrospective.id
    end
    assert_response :success
    assert_equal "Group#{Retrospective.find(:all).size}", assigns("group").title
  end

end