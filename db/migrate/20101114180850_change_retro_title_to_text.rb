class ChangeRetroTitleToText < ActiveRecord::Migration
  def self.up
    change_table :retrospectives do |t|
      t.change :title, :text
    end
  end

  def self.down
    change_table :retrospectives do |t|
      t.change :title, :string
    end
  end
end
