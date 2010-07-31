require 'test_helper'

class RetrospectivesControllerTest < ActionController::TestCase
  setup do
    @retrospective = retrospectives(:retrospective_1)
  end

  test "should display sections on show retrospective page" do
    get :show, :id => @retrospective.to_param
    assert_select 'td.title', 1
  end

  test "should display 1 to 3 sections in a single row" do
    create_section('2') 
    create_section('3')
    get :show, :id => @retrospective.to_param
    assert_select 'tr.section-row', 1
    assert_select 'td.title', 3
  end

  test "should display 2 sections per row when more than 3 sections" do
    create_section('2')
    create_section('3')
    create_section('4')
    get :show, :id => @retrospective.to_param
    assert_select 'tr.section-row', 2
    assert_select 'td.title', 4
  end

  def create_section(title_appendix)
    section = Section.new
    section.title = "section#{title_appendix}"
    section.retrospective = @retrospective
    section.save
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
