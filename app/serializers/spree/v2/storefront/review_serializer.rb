module Spree
  module V2
    module Storefront
      class ReviewSerializer < BaseSerializer
        set_type :review

        attributes :title, :review

        has_one :user
        has_one :product
      end
    end
  end
end
