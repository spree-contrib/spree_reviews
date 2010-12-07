require 'spree_core'
require 'spree_reviews_hook'

module SpreeReviews
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end
      # Add access to reviews/ratings to the product model
      Product.class_eval do
        has_one :rating
        has_many :reviews

        def get_stars
          if rating.nil?
            [0,0]
          else
            [rating.get_stars, rating.count]
          end
        end
      end

    end

    config.to_prepare &method(:activate).to_proc
  end
end
