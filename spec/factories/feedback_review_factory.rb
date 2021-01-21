FactoryBot.define do
  factory :feedback_review, class: Spree::FeedbackReview do
    user
    review
    comment { generate(:random_description) }
    rating  { rand(1..5) }
  end
end
