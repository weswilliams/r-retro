class CreateItemVotes < ActiveRecord::Migration
  def self.up
    create_table :item_votes do |t|
      t.belongs_to :item

      t.timestamps
    end
  end

  def self.down
    drop_table :item_votes
  end
end
