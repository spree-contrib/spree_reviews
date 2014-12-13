# Add access to reviews/ratings to the product model
Spree::Product.class_eval do
  has_many :reviews

  def stars
    avg_rating.try(:round) || 0
  end

  def recalculate_rating
    reviews_count = reviews.reload.approved.count
    self.reviews_count = reviews_count
    if reviews_count > 0
      self.avg_rating = reviews.approved.sum(:rating).to_f / reviews_count
    else
      self.avg_rating = 0
    end
    self.save
  end
end
