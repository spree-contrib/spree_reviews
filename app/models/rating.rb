class Rating < ActiveRecord::Base
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
