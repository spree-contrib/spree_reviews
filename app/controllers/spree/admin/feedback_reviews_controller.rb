module Spree
  module Admin
    class FeedbackReviewsController < ResourceController
      belongs_to 'spree/review'

      def index
        @collection = parent.feedback_reviews
      end
    end
  end
end
