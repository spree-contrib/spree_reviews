module SpreeReviews
  module ProductSerializerDecorator
    def self.prepended(base)

      base.attributes :avg_rating, :reviews_count
      base.has_many :reviews
    end
  end
end

Spree::V2::Storefront::ProductSerializer.prepend(SpreeReviews::ProductSerializerDecorator)