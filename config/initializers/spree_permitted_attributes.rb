module Spree
  module PermittedAttributes
    _ATTRIBUTES = %i[review_attributes feedback_review_attributes]

    Spree::PermittedAttributes::ATTRIBUTES.push(*_ATTRIBUTES)
    mattr_reader *_ATTRIBUTES

    @@product_attributes += %i[avg_rating reviews_count]
    @@review_attributes = [:rating, :title, :review, :name, :show_identifier]
    @@feedback_review_attributes = [:rating, :comment]
  end
end
