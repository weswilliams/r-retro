class CreateRetrospectives < ActiveRecord::Migration
  def self.up
    create_table :retrospectives do |t|
      t.string :title
      t.timestamps
    end
  end

  def self.down
    drop_table :retrospectives
  end
end
