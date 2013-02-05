FactoryGirl.define do
  factory :review, :class => Spree::Review do |f|
    name { Faker::Internet.email }
    title { Faker::Lorem.words(4).join(' ') }
    review { Faker::Lorem.paragraphs(3).join("\n") }
    rating { (rand * 4).to_i + 1 }
    approved false

    association(:user, :factory => :user)
    association(:product, :factory => :product)
  end
end