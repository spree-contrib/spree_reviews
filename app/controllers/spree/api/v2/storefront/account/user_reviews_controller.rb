module Spree
  module Api
    module V2
      module Storefront
        module Account
          class UserReviewsController < ::Spree::Api::V2::BaseController
            before_action :require_spree_current_user

            # GET /api/v2/storefront/account/reviews
            def index
              render_serialized_payload { serialize_collection(resource) }
            end

            private

            def resource
              resource_finder.user_reviews(spree_current_user.id).most_recent_first
            end

            def collection_serializer
              Spree::V2::Storefront::ReviewSerializer
            end

            def serialize_collection(collection)
              collection_serializer.new(
                collection,
                include: resource_includes,
                fields: sparse_fields
              ).serializable_hash
            end

            def resource_finder
              Spree::Review
            end
          end
        end
      end
    end
  end
end
