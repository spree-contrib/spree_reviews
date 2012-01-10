class Spree::Admin::FeedbackReviewsController <  Spree::Admin::ResourceController
  def index
    @review = Spree::Review.find(params[:review_id])
    @collection = @review.feedback_reviews
  end
end
