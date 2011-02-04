module RetrospectivesHelper

  def theme_options
    @files = Dir.glob("public/stylesheets/palettes/*")
    theme_name = ['default']
    @files.each do |f|
      theme_name << /\A.*scaffold-(.*).css\z/.match(f)[1]
    end
    theme_name
  end

  def section_rows(sections_per_row = 2)
    rows = []
    @retrospective.sections.each_slice(sections_per_row) { |row| rows.push row }
    rows
  end

  def inline_edit_item_with_remote_update(options = [])
    id = options[:id]
    url = options[:url]
    refresh_url = options[:refresh_url] || ''
    element_id = options[:element_id] || 'add_item'
    on_complete = options[:on_complete] || ", onComplete: function(transport, element) {#{remote_function(:url => refresh_url)};}"
    rows = options[:rows] || '1'

    code = <<-eos
    var #{element_id}_editor#{id} = new Ajax.InPlaceEditor('inline_#{element_id}_#{id}',
            '#{url}', {
      externalControl:"inline_#{element_id}_#{id}",
      highlightcolor: 'transparent',
      rows: #{rows},
      cancelText: '(cancel)',
      okText: '(ok)',
      clickToEditText: 'double click to edit'#{on_complete}
    });
    $("inline_#{element_id}_#{id}").ondblclick = function() {
      #{element_id}_editor#{id}.enterEditMode();
    }
    #{element_id}_editor#{id}.dispose();
    eos
    javascript_tag(code)
  end

end
