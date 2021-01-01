class Spree::ReviewsAbility
  include CanCan::Ability

  def initialize(user)
    review_ability_class = self.class
    can :create, Spree::Review do
      review_ability_class.allow_anonymous_reviews? || !user.email.blank?
    end
    can :create, Spree::FeedbackReview do
      review_ability_class.allow_anonymous_reviews? || !user.email.blank?
    end
  end

  def self.allow_anonymous_reviews?
    !SpreeReviews::Config[:require_login]
  end
end
