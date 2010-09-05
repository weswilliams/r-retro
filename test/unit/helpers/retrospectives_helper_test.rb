require 'test_helper'

class RetrospectivesHelperTest < ActionView::TestCase

  test "section 0 is beginning row with 1 section" do
    create_retro_with_1_section
  end

  def method_missing(id, *args, &block)
    return create_retro_with_sections($1.to_i) if id.to_s =~ /^create_retro_with_(\d+)_section[s]?/
    super  
  end

  private

  def create_retro_with_sections(number_of_sections = 1)
    @retrospective = Retrospective.new
    number_of_sections.times { @retrospective.sections.push Section.new }
  end

end
