module SpreeReviews
  class Engine < Rails::Engine
    engine_name 'spree_reviews'

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end
      
      Spree::Ability.register_ability(Spree::ReviewsAbility)
    end

    config.to_prepare &method(:activate).to_proc
  end
end
