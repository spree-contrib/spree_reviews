FactoryGirl.define do
  factory :feedback_review, :class => Spree::FeedbackReview do |f|
    user
    review
    comment { Faker::Lorem.paragraphs(3).join("\n") }
    rating { (rand * 4).to_i + 1 }
  end
end