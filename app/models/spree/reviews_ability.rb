class Spree::ReviewsAbility
  include CanCan::Ability

  def initialize user
    can :create, Spree::Review do |review|
      !Spree::Reviews::Config[:require_login] || (user.email and !user.anonymous?)
    end
    can :create, Spree::FeedbackReview do |review|
      !Spree::Reviews::Config[:require_login] || (user.email and !user.anonymous?)
    end
  end
end
