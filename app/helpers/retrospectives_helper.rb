module RetrospectivesHelper

#  <%= periodically_call_remote(:url => refresh_retrospective_url(:section_id => section)) %>

  def periodically_call_remote(options = {})
     frequency = options[:frequency] || 10 # every ten seconds by default
     code = "new PeriodicalExecuter(function() {#{remote_function(options)}}, #{frequency})"
     javascript_tag(code)
   end

  def beginning_row_index_for_ending_index(ending_row_index)
    return 0 if is_in_first_row(ending_row_index)
    is_single_continuing_row_and_last_section(ending_row_index) ?
            ending_row_index :
            ending_row_index - (calculate_sections_per_row - 1)
  end

  def is_single_continuing_row_and_last_section(ending_row_index)
    is_not_in_first_row(ending_row_index) && is_last_section(ending_row_index)
  end

  def number_of_item_columns_for(index)
    is_last_section(index) ? 1 : calculate_sections_per_row
  end

  def calculate_sections_per_row()
    @retrospective.sections.length <= 3 ? 3 : 2
  end

  def is_starting_row(index)
    index == 0 || (index % calculate_sections_per_row == 0)
  end

  def is_last_section(index)
    index == @retrospective.sections.length - 1
  end

  def is_in_first_row(index)
    index < calculate_sections_per_row
  end

  def is_first_ending_row(index)
    is_in_first_row(index) && calculate_sections_per_row - index == 1
  end

  def is_not_in_first_row(index)
    index > calculate_sections_per_row
  end

  def is_continuing_ending_row(index)
    sections_per_row = calculate_sections_per_row
    is_not_in_first_row(index) && index % sections_per_row == 1
  end

  def is_ending_row(index)
    sections_per_row = calculate_sections_per_row
    is_last_section(index) ||
            is_first_ending_row(index) ||
            is_continuing_ending_row(index)
  end


end
