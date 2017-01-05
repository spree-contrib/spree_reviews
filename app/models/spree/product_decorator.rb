# Add access to reviews/ratings to the product model
Spree::Product.class_eval do
  has_many :reviews

  def stars
    avg_rating.try(:round) || 0
  end

  def recalculate_rating
    self[:reviews_count] = reviews.reload.approved.count
    if reviews_count > 0
      self[:avg_rating] = reviews.approved.sum(:rating).to_f / reviews_count
    else
      self[:avg_rating] = 0
    end
    save
  end

  def not_reviewed_by?(user)
    self.reviews.find_by(user_id: user.id).nil?
  end
end
