module RetrospectivesHelper

  def inline_edit_item_with_remote_update(options = [])
    id = options[:id]
    url = options[:url]
    refresh_url = options[:refresh_url] || ''
    element_id = options[:element_id] || 'add_item'
    on_complete = options[:on_complete] || ", onComplete: function(transport, element) {#{remote_function(:url => refresh_url)};}"
    
    code = <<-eos
    var #{element_id}_editor#{id} = new Ajax.InPlaceEditor('inline_#{element_id}_#{id}',
            '#{url}', {
      externalControl:"#{element_id}_#{id}",
      highlightcolor: 'transparent',
      cancelText: '(cancel)',
      okText: '(ok)',
      clickToEditText: ''#{on_complete}
    });
    $("#{element_id}_#{id}").onclick = function() {
      #{element_id}_editor#{id}.enterEditMode();
    }
    #{element_id}_editor#{id}.dispose();
    eos
    javascript_tag(code)
  end

  # could not find this method in rails 3 prototype helper, not sure why, cannot find a reason
  #<%= periodically_call_remote(:url => refresh_retrospective_url(:section_id => section), :frequency => 20) %>
  def periodically_call_remote(options = {})
     frequency = options[:frequency] || 10 # every ten seconds by default
     condition = options[:condition] || true
     code = "new PeriodicalExecuter(function() {if (#{condition}) #{remote_function(options)}}, #{frequency})"
     javascript_tag(code)
   end

  def calculate_sections_per_row()
    @retrospective.sections.length <= 3 ? 3 : 2
  end

  def section_column_span(index)
    (is_starting_row(index) && is_last_section(index)) ? calculate_sections_per_row : 1
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
