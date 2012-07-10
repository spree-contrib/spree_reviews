# Add access to reviews/ratings to the product model
Spree::Product.class_eval do
  has_many :reviews

  attr_accessible :avg_rating, :reviews_count

  def stars
    avg_rating.round
  end
end
