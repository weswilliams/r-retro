class ItemVote < ActiveRecord::Base
  belongs_to :item
  validates_presence_of :item
end
