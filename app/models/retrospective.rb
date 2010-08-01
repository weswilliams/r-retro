class Retrospective < ActiveRecord::Base

  has_many :sections, :dependent => :destroy

  validates :title, :presence => true

  def to_param
    "#{id}-#{title.gsub(/[^a-z0-9]+/i, '-')}"
  end
  
end
