FactoryGirl.define do
  factory :review, :class => Spree::Review do |f|
    name   { generate(:random_email) }
    title  { generate(:random_string) }
    review { generate(:random_description) }
    rating { rand(1..5) }
    approved false
    user
    product

    trait :approved do
      approved true
    end
  end
end