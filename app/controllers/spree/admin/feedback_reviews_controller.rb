class Spree::Admin::FeedbackReviewsController <  Spree::Admin::ResourceController
  belongs_to 'spree/review'

  def index
    @collection = parent.feedback_reviews
  end
end
