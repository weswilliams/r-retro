class AddColorToSection < ActiveRecord::Migration
  def self.up
    add_column :sections, :color, :string
    Section.update_all ["color = ?", 'f8f291']
  end

  def self.down
    remove_column :sections, :color
  end
end
