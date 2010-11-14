class ChangeRetroTitleToText < ActiveRecord::Migration
  def self.up
    change_table :retrospectives do |t|
      t.change :title, :text, :limit => 1000
    end
  end

  def self.down
    change_table :retrospectives do |t|
      t.change :title, :string, :limit => 255
    end
  end
end
