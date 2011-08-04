require 'spree_core'
require 'spree_reviews_hooks'

module SpreeReviews
  
  class AbilityDecorator
    include CanCan::Ability

    def initialize(user)
      can :create, Review do |review|
        user.has_role?(:user) || !Spree::Reviews::Config[:require_login]
      end
      can :create, FeedbackReview do |review|
        user.has_role?(:user) || !Spree::Reviews::Config[:require_login]
      end
    end
  end

  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end
      ProductsHelper.send(:include, ReviewsHelper)
      Admin::ReviewsController.cache_sweeper :review_sweeper
      Ability.register_ability(AbilityDecorator)
    end

    config.to_prepare &method(:activate).to_proc
  end
end
