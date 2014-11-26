FactoryGirl.define do
  factory :feedback_review, class: Spree::FeedbackReview do |f|
    user
    review
    comment { generate(:random_description) }
    rating  { rand(1..5) }
  end
end
