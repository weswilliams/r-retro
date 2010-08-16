class Item < ActiveRecord::Base
  belongs_to :section
  has_many :item_votes, :dependent => :destroy
  validates :section, :value, :presence => true
end
