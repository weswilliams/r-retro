require 'test_helper'

class RetrospectivesHelperTest < ActionView::TestCase

  test "should calculate single items column for last row with odd number of sections" do
    create_retro_with_5_sections
    assert_equal 2, number_of_item_columns_for(1)
    assert_equal 2, number_of_item_columns_for(3)
    assert_equal 1, number_of_item_columns_for(4)
  end

  test "sections per row" do
    create_retro_with_1_section
    assert_equal 3, calculate_section_per_row

    create_retro_with_2_sections
    assert_equal 3, calculate_section_per_row

    create_retro_with_3_sections
    assert_equal 3, calculate_section_per_row

    create_retro_with_4_sections
    assert_equal 2, calculate_section_per_row
  end

  test "section 0 is beginning row with 1 section" do
    create_retro_with_1_section
    assert_start_rows [0]
  end

  test "section 0 is only beginning row with 3 sections" do
    create_retro_with_3_sections
    assert_start_rows [0]
    assert_not_start_rows [1,2]
  end

  test "sections 0 and 2 are the only beginning row with 6 sections" do
    create_retro_with_6_sections
    assert_start_rows [0,2,4]
    assert_not_start_rows [1,3,5]
  end

  test "section 0 is ending row with 1 section" do
    create_retro_with_1_section
    assert_is_ending_row [0]
  end

  test "section 2 is ending row with 3 section" do
    create_retro_with_3_sections
    assert_is_ending_row [2]
    assert_is_not_ending_row [0,1]
  end

  test "section 1 and 3 are ending rows with 4 sections" do
    create_retro_with_4_sections
    assert_is_ending_row [1,3]
  end

  def method_missing(id, *args, &block)
    return create_retro_with_sections($1.to_i) if id.to_s =~ /^create_retro_with_(\d+)_section[s]?/
    super  
  end

  private

  def assert_is_ending_row(sections)
    sections.each {|section| assert is_ending_row(section), "section #{section} should be a ending row" }
  end

  def assert_is_not_ending_row(sections)
    sections.each {|section| assert !is_ending_row(section), "section #{section} should NOT be a ending row" }
  end

  def assert_start_rows(sections)
    sections.each {|section| assert is_starting_row(section), "section #{section} should be a start row" }
  end

  def assert_not_start_rows(rows)
    rows.each {|row| assert !is_starting_row(row), "section #{row} should NOT be a start row" }
  end

  def create_retro_with_sections(number_of_sections = 1)
    @retrospective = Retrospective.new
    number_of_sections.times { @retrospective.sections.push Section.new }
  end

end
