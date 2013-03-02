class Spree::ReviewsAbility
  include CanCan::Ability

  def initialize(user)
    user ||= Spree.user_class.new
    can :create, Spree::Review do |review|
      user.respond_to?(:has_spree_role?) && user.has_spree_role?('review')
    end
    can :create, Spree::FeedbackReview do |review|
      user.respond_to?(:has_spree_role?) && user.has_spree_role?('review')
    end
  end
end
