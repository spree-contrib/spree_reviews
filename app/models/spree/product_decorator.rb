# Add access to reviews/ratings to the product model
Spree::Product.class_eval do
  has_many :reviews

  def get_stars
    [avg_rating.round, reviews_count]
  end
end
