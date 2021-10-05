module Spree
  module Api
    module V2
      module Storefront
      class ReviewsController < ::Spree::Api::V2::BaseController
          include Spree::Api::V2::CollectionOptionsHelpers
          include Spree::BaseHelper

        before_action :require_spree_current_user, only:[:create]

        def index
            reviews = collection.all.page(params[:page]).per(params[:per_page])
            render_serialized_payload { serialize_collection(reviews) }
          end

        def create
          review = Spree::Review.new(review_params)
          review.product = Spree::Product.find_by(id: params[:review][:product])
          if not review.product
            review.product = Spree::Product.find_by(slug: params[:review][:product])
          end
          review.user = spree_current_user 
          review.ip_address = request.remote_ip
          review.locale = I18n.locale.to_s if Spree::Reviews::Config[:track_locale]
          review.save
      
          if review.persisted?
            render_serialized_payload { serialize_resource(review) }
            else
            render_error_payload(review.errors.full_messages.to_sentence)
        end

        end

        private

        def permitted_review_attributes
          [:rating, :title, :review, :name, :show_identifier]
        end

        def review_params
          params.require(:review).permit(permitted_review_attributes)
        end

        def model_class
            ::Spree::Review
          end

          def scope
            ::Spree::Review
          end

          def collection
            @collection ||= collection_finder.new(scope: scope, params: params).execute
          end

          def collection_finder
            Spree::Reviews::Find
          end

          def resource_serializer
            Spree::V2::Storefront::ReviewSerializer
          end

          def collection_serializer
            Spree::V2::Storefront::ReviewSerializer
          end
        
        end
      end
    end
  end
end
