class Spree::ReviewsAbility
  include CanCan::Ability

  def initialize(user)
    can :create, Spree::Review do |review|
      user.has_role?(:user) || !Spree::Reviews::Config[:require_login]
    end
    can :create, Spree::FeedbackReview do |review|
      user.has_role?(:user) || !Spree::Reviews::Config[:require_login]
    end
  end
end
