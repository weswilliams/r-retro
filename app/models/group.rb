class Group < ActiveRecord::Base
  has_many :items, :dependent => :nullify

  validates :retrospective_id, :presence => true
  validates :title, :presence => true

end
