module Spree
  module V2
    module Storefront
      class ReviewSerializer < BaseSerializer
        set_type :review

        attributes :rating, :title, :review, :name, :show_identifier,:approved, :created_at

        belongs_to  :product
        belongs_to :user

      end
    end
  end
end