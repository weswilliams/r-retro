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

end
