module RetrospectivesHelper
  def calculate_section_per_row()
    @retrospective.sections.length <= 3 ? 3 : 2
  end

  def is_starting_row(index)
    index == 0 || (index % calculate_section_per_row == 0)
  end

  def is_last_section(index)
    index == @retrospective.sections.length - 1
  end

  def is_ending_row(index)
    sections_per_row = calculate_section_per_row
    is_last_section(index) ||
      (index < sections_per_row && sections_per_row - index == 1) ||
      (index > sections_per_row && index % sections_per_row == 1)

  end

end
