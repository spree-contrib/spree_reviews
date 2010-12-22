class FeedbackReview < ActiveRecord::Base
  belongs_to :review

  validates_presence_of :review_id
  validates_numericality_of :rating, :only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 5, :message => "You must enter a value for rating"

  default_scope order("feedback_reviews.created_at DESC")

end
