require 'test_helper'

class RetrospectivesControllerTest < ActionController::TestCase
  setup do
    @retrospective = retrospectives(:retrospective_1)
  end

  def method_missing(id, *args, &block)
    return show_with_sections_and_expect_rows($1.to_i, $2.to_i) if id.to_s =~ /^show_with_(\d+)_section[s]?_and_expect_(\d+)_row[s]?/
    super
  end

  test "should display section 1 items" do
    show_with_1_section_and_expect_1_row
    assert_select 'ul.items', 1
    assert_select 'li.item', 1
  end

  test "should display sections on show retrospective page" do
    show_with_1_section_and_expect_1_row
  end

  test "should display 1 to 3 sections in a single row" do
    show_with_3_sections_and_expect_1_row
  end

  test "should display 2 sections per row when more than 3 sections" do
    show_with_4_sections_and_expect_2_rows
  end

  def show_with_sections_and_expect_rows(sections, expected_rows)
    (2..sections).each {|cnt| create_section(cnt.to_s) }
    get :show, :id => @retrospective.to_param
    assert_select 'tr.section_row', expected_rows
    assert_select 'td.title', sections
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
