# Add access to reviews/ratings to the product model
module Spree::ProductDecorator
  def self.prepended(base)
    base.has_many :reviews
  end

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
end

::Spree::Product.prepend(Spree::ProductDecorator)
