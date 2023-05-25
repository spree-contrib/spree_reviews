module SpreeReviews
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_reviews'

    config.autoload_paths += %W[#{config.root}/lib]
    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    initializer 'spree_reviews.environment', before: :load_config_initializers do |_app|
      Config = Configuration.new
    end

    config.after_initialize do
      Spree::Reviews::Config = Spree::ReviewSetting.new
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
      Spree::Ability.register_ability(Spree::ReviewsAbility)
    end

    config.to_prepare(&method(:activate).to_proc)
  end
end
