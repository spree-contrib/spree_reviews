# Add access to reviews/ratings to the product model
Spree::Product.class_eval do
  has_many :reviews

  def stars
    avg_rating.round
  end
end
