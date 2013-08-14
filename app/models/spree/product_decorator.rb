# Add access to reviews/ratings to the product model
Spree::Product.class_eval do
  has_many :reviews, :as => :reviewable, :dependent => :destroy

  attr_accessible :avg_rating, :reviews_count

  def stars
    avg_rating.round
  end

  def display_reviews
    Spree::Reviews::Config[:product_reviews]
  end
end
