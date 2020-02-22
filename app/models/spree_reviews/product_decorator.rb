module SpreeReviews
  module ProductDecorator

      def self.prepended(base)
        base.has_many :reviews
      end

      def stars
        avg_rating.try(:round) || 0
      end

      def accurate_average
        avg_rating.round(1) || 0
      end

      def last_star_percentage
        (avg_rating.modulo(1)).round(1) * 100 || 0
      end

      def recalculate_rating
        self[:reviews_count] = reviews.reload.approved.count
        if reviews_count > 0
          self[:avg_rating] = reviews.approved.sum(:rating).to_f / reviews_count
        else
          self[:avg_rating] = 0
        end
        save
      end

  end
end

::Spree::Product.prepend SpreeReviews::ProductDecorator
