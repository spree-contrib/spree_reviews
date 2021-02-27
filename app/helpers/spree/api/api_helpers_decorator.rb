# frozen_string_literal: true

module Spree
  module Api
    module ApiHelpersDecorator
      def self.prepended(base)
        base.module_eval do
          @@review_attributes = [
            :id, :product_id, :name, :location, :rating, :title, :review, :approved,
            :created_at, :updated_at, :user_id, :ip_address, :locale, :show_identifier
          ]

          @@feedback_review_attributes = [
            :id, :user_id, :review_id, :rating, :comment, :created_at, :updated_at, :locale
          ]

          def review_attributes
            @@review_attributes
          end

          def feedback_review_attributes
            @@feedback_review_attributes
          end

          reviews_fields = [:avg_rating, :reviews_count]

          reviews_fields.each do |attrib|
            ::Spree::PermittedAttributes.product_attributes << attrib
            class_variable_set(:@@product_attributes, class_variable_get(:@@product_attributes).push(attrib))
          end
        end
      end

      ::Spree::Api::ApiHelpers.prepend self if ::Spree::Api::ApiHelpers.included_modules.exclude?(self)
    end
  end
end
