class FeedbackReview < ActiveRecord::Base
  belongs_to :review
  belongs_to :user

  validates_presence_of :review_id
  validates_numericality_of :rating, :only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 5, :message => I18n.t('you_must_enter_value_for_rating')

  default_scope order("feedback_reviews.created_at DESC")

end
