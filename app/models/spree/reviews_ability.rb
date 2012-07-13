class Spree::ReviewsAbility
  include CanCan::Ability

  def initialize(user)
    can :create, Spree::Review do |review|
      !user.anonymous? || !Spree::Reviews::Config[:require_login]
    end
    can :create, Spree::FeedbackReview do |review|
      !user.anonymous? || !Spree::Reviews::Config[:require_login]
    end
  end
  Spree::Ability.register_ability(Spree::ReviewsAbility)
end
