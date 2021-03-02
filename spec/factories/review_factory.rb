FactoryBot.define do
  factory :review, class: Spree::Review do
    name   { generate(:random_email) }
    title  { generate(:random_string) }
    review { generate(:random_description) }
    rating { rand(1..5) }
    approved { false }
    show_identifier { true }
    user
    product

    trait :approved do
      approved { true }
    end

    trait :hide_identifier do
      show_identifier { false }
    end
  end
end
