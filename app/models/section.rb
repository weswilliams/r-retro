class Section < ActiveRecord::Base

  belongs_to :retrospective
  has_many :items, :dependent => :destroy

  validates :retrospective_id, :presence => true
  validates :title, :presence => true

end
