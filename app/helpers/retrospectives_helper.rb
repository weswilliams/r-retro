module RetrospectivesHelper
  def calculate_section_per_row(retrospective)
    retrospective.sections.length <= 3 ? 3 : 2
  end

  def is_starting_row(index, retrospective)
    index == 0 || (index % calculate_section_per_row(retrospective) == 0)
  end

  def is_last_section(index, retrospective)
    index == retrospective.sections.length - 1
  end

  def is_ending_row(index, retrospective)
    sections_per_row = calculate_section_per_row(retrospective)
    is_last_section(index, retrospective) ||
      (index < sections_per_row && sections_per_row - index == 1) ||
      (index > sections_per_row && index % sections_per_row == 1)

  end

end
