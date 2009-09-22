class Rating < ActiveRecord::Base
  belongs_to :product

  NB_STARS=5
  def self.get_nb_stars
    NB_STARS
  end

  def add_rating(n)
    self.value = value * count + n
    self.count = count + 1
    self.value = value / count
    save
  end
  
  def get_stars
    (self.value + 0.5).floor
  end
  
end
