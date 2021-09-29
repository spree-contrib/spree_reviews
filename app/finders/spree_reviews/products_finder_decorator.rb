module SpreeReviews
  module ProductsFinderDecorator
    def initialize(scope:, params:, current_currency: nil)
      super

      @avg_ratings  = params.dig(:filter, :avg_ratings)&.split(',')
    end

    def execute
      products = by_ratings(super)

      products.distinct
    end

    private

    attr_reader :avg_ratings

    def avg_ratings?
      avg_ratings.present?
    end

    def by_ratings(products)
      return products unless avg_ratings?
      products.where(avg_rating: avg_ratings)
    end
  end
end

::Spree::Products::Find.prepend(SpreeReviews::ProductsFinderDecorator)