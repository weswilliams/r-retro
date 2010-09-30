class Section < ActiveRecord::Base

  belongs_to :retrospective
  has_many :items, :dependent => :destroy

  validates :retrospective_id, :presence => true
  validates :title, :presence => true

  DEFAULT_COLORS = ['f8f291', '98f891', '91f8e8', 'f891f7', 'f891a4', '9191f8']

  before_save :defaults

  def defaults
    num_of_sections = Section.where("retrospective_id = ?", retrospective.id).size
    self.color = DEFAULT_COLORS[num_of_sections % DEFAULT_COLORS.size] unless self.color
    p "color is #{color}"
  end

end
