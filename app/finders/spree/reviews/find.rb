module Spree
  module Reviews
    class Find
      def initialize(scope:, params:)
        @scope = scope
        @products  = params.dig(:filter, :product_ids)&.split(',')
        @approved  = params.dig(:filter, :approved)
        @order  = params.dig(:filter, :order_by)        
      end

      def execute
        reviews = by_product(scope)
        reviews = by_approved(reviews)
        reviews = by_order(reviews)

        reviews
      end

      private

      attr_reader :products, :approved, :order, :scope

      def products?
        products.present?
      end

      def approved?
        approved.present?
      end

      def order?
        order.present?
      end

      def by_product(reviews)
        return reviews unless products?
        reviews.where(product_id: products)
      end

      def by_approved(reviews)
        return reviews unless approved?
        reviews.where(approved: approved)
      end

      def by_order(reviews)
        return reviews unless order?
        if order == 'latest'
          reviews.reorder("created_at ASC")
        elsif order == 'oldest'
          reviews.reorder("created_at DESC")
        elsif order == 'highest'
          reviews.reorder("rating ASC")
        elsif order == 'lowest'
          reviews.reorder("rating DESC")
        end        

      end
    end
  end
end