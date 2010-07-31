class Item < ActiveRecord::Base
  belongs_to :section
  validates :section, :value, :presence => true
end
