module Spree::ProductsControllerDecorator
  extend ActiveSupport::Concern
  included do
    helper Spree::ReviewsHelper
  
    reviews_fields = [:avg_rating, :reviews_count]
    reviews_fields.each { |attrib| Spree::PermittedAttributes.product_attributes << attrib }
  
    Spree::Api::ApiHelpers.class_eval do
      reviews_fields.each { |attrib| class_variable_set(:@@product_attributes, class_variable_get(:@@product_attributes).push(attrib)) }
    end
  end
end

if ::Spree::ProductsController.included_modules.exclude?(Spree::ProductsControllerDecorator)
  ::Spree::ProductsController.prepend Spree::ProductsControllerDecorator
end

