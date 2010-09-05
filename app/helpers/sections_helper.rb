module SectionsHelper

  def is_odd_row(counter)
    (counter % 2) != 0
  end

  def is_even_row(counter)
    (counter % 2) == 0
  end
  
end
