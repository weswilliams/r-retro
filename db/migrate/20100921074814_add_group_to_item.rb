class AddGroupToItem < ActiveRecord::Migration
  def self.up
    change_table :items do |t|
      t.belongs_to :group
    end
  end

  def self.down
    remove_column :items, :group_id
  end
end
