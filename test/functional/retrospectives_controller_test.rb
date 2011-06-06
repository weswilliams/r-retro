require 'test_helper'

class RetrospectivesControllerTest < ActionController::TestCase
  setup do
    @retrospective = retrospectives(:retrospective_1)
    @sections = @retrospective.sections
  end

  def method_missing(id, *args, &block)
    return show_with_sections($1.to_i) if id.to_s =~ /^show_with_(\d+)_section[s]?/
    super
  end

  test "user should see the retrospective if the id and title are known" do
    get :show, :id => @retrospective.to_param
    assert_select "span#inline_retrospective_title_#{@retrospective.id}", @retrospective.title
  end

  test "user should see the home page if the id and title of the retrospective are not known" do
    get :show, :id => @retrospective.id
    assert_redirected_to retrospectives_path
  end

  test "should display section 1 items" do
    show_with_1_section_and_expect_1_row
    assert_select 'div.section_items' do
      assert_select "div#section_item_#{@sections[0].id}", 1
    end
  end

  test "should display sections on show retrospective page" do
    show_with_1_section
  end

  test "should display 1 to 3 sections in a single row" do
    show_with_3_sections
  end

  test "should display 2 sections per row when more than 3 sections" do
    show_with_4_sections
  end

  def show_with_sections(sections)
    (2..sections).each {|cnt| create_section(cnt.to_s) }
    group_titles = 1
    get :show, :id => @retrospective.to_param
    assert_select 'div.section', sections
    assert_select 'div.title', sections + group_titles
  end

  def create_section(title_appendix)
    section = Section.new
    section.title = "section#{title_appendix}"
    section.retrospective = @retrospective
    section.save
    @sections.push(section)
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
