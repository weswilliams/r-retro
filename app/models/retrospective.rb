class Retrospective < ActiveRecord::Base

  has_many :sections, :dependent => :destroy, :order => 'created_at ASC'

  has_many :groups, :dependent => :destroy

  validates :title, :presence => true

  def to_param
    "#{id}-#{title.gsub(/[^a-z0-9]+/i, '-')}"
  end
  
end
