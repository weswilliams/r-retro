class Item < ActiveRecord::Base
  belongs_to :section
  belongs_to :group
  has_many :item_votes, :dependent => :destroy
  validates :section, :presence => true
end
