require 'spree_core'
require 'spree_reviews_hook'

module SpreeReviews
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end
      ProductsHelper.send(:include, ReviewsHelper)
      Admin::ReviewsController.cache_sweeper :review_sweeper
    end

    config.to_prepare &method(:activate).to_proc
  end
end
