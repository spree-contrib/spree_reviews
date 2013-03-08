class Spree::ReviewsAbility
  include CanCan::Ability

  def initialize user
    can :create, Spree::Review do |review|
      !Spree::Reviews::Config[:require_login] || user
    end
    can :create, Spree::FeedbackReview do |review|
      !Spree::Reviews::Config[:require_login] || user
    end
  end
end
