module SpreeReviews
  module ProductsControllerDecorator

    def self.included(base)
      base.include ::Spree::ReviewsHelper
      base.helper_method *::Spree::ReviewsHelper.public_instance_methods
    end

    def self.preneded(base)
      reviews_fields = [:avg_rating, :reviews_count]
      reviews_fields.each { |attrib| Spree::PermittedAttributes.product_attributes << attrib }
    end

  end
end

::Spree::ProductsController.include(SpreeReviews::ProductsControllerDecorator)
