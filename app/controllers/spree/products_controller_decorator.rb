Spree::ProductsController.class_eval do
  helper Spree::ReviewsHelper

  [:avg_rating, :reviews_count].each { |attrib| Spree::PermittedAttributes.product_attributes << attrib }
end
