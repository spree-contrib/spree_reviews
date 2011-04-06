# Add access to reviews/ratings to the product model
Product.class_eval do
  has_many :reviews

  def get_stars
    [avg_rating.round, reviews_count]
  end
  
  def recalculate_rating
    reviews_count = reviews.approved.count    
    if reviews_count > 0
      self.update_attribute :avg_rating, self.reviews.approved.sum(:rating).to_f / reviews_count
    else
      self.update_attribute :avg_rating, 0
    end
  end
end
