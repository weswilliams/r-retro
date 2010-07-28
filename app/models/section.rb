class Section < ActiveRecord::Base

  belongs_to :retrospective

  validates :retrospective_id, :presence => true
  validates :title, :presence => true
  
end
