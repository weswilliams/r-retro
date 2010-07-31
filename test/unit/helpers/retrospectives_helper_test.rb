require 'test_helper'

class RetrospectivesHelperTest < ActionView::TestCase

  test "sections per row" do
    assert_equal 3, calculate_section_per_row(create_retro_with_sections(1))
    assert_equal 3, calculate_section_per_row(create_retro_with_sections(2))
    assert_equal 3, calculate_section_per_row(create_retro_with_sections(3))
    assert_equal 2, calculate_section_per_row(create_retro_with_sections(4))
  end

  test "section 0 is beginning row with 1 section" do
    assert_start_rows([0], create_retro_with_1_section)
  end

  test "section 0 is only beginning row with 3 sections" do
    retrospective = create_retro_with_3_sections
    assert_start_rows([0], retrospective)
    assert_not_start_rows([1,2], retrospective)
  end

  test "sections 0 and 2 are the only beginning row with 6 sections" do
    retrospective = create_retro_with_6_sections
    assert_start_rows([0,2,4], retrospective)
    assert_not_start_rows([1,3,5], retrospective)
  end

  test "section 0 is ending row with 1 section" do
    assert_is_ending_row([0], create_retro_with_1_section)
  end

  test "section 2 is ending row with 3 section" do
    retrospective = create_retro_with_3_sections
    assert_is_ending_row [2], retrospective
    assert_is_not_ending_row [0,1], retrospective
  end

  test "section 1 and 3 are ending rows with 4 sections" do
    assert_is_ending_row([1,3], create_retro_with_4_sections)
  end

  def method_missing(id, *args, &block)
    return create_retro_with_sections($1.to_i) if id.to_s =~ /^create_retro_with_(\d+)_section[s]?/
    super  
  end

  private

  def assert_is_ending_row(sections, retrospective)
    sections.each {|section| assert is_ending_row(section, retrospective), "section #{section} should be a ending row" }
  end

  def assert_is_not_ending_row(sections, retrospective)
    sections.each {|section| assert !is_ending_row(section, retrospective), "section #{section} should NOT be a ending row" }
  end

  def assert_start_rows(sections, retrospective)
    sections.each {|section| assert is_starting_row(section, retrospective), "section #{section} should be a start row" }
  end

  def assert_not_start_rows(rows, retrospective)
    rows.each {|row| assert !is_starting_row(row, retrospective), "section #{row} should NOT be a start row" }
  end

  def create_retro_with_sections(number_of_sections = 1)
    retrospective = Retrospective.new
    number_of_sections.times { retrospective.sections.push Section.new }
    retrospective
  end

end
