# Add access to reviews/ratings to the product model
Spree::Product.class_eval do
  has_many :reviews

  def get_stars
    [avg_rating.round, reviews_count]
  end

  def recalculate_rating
    reviews_count = reviews.reload.approved.count
    if reviews_count > 0
      self.update_attributes(:avg_rating => self.reviews.approved.sum(:rating).to_f / reviews_count, :reviews_count => reviews_count)
    else
      self.update_attribute :avg_rating, 0
    end
  end
end
