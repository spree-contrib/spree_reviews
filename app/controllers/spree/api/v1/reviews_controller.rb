module Spree
  module Api
    module V1
      class ReviewsController < Spree::Api::BaseController
        before_action :find_product, only: [:index, :create]

        def index
          @reviews = Spree::Review.approved
            .where(product: @product)
            .page(params[:page])
            .per(params[:per_page])
          respond_with(@reviews)
        end

        def show
          @review = Spree::Review.approved.find(params[:id])
          respond_with(@review)
        end

        def create
          @review = Spree::Review.new(review_params)
          @review.product = @product
          @review.user = spree_current_user if spree_user_signed_in?
          @review.ip_address = request.remote_ip
          @review.locale = I18n.locale.to_s if Spree::Reviews::Config[:track_locale]

          authorize! :create, @review
          if @review.save
            respond_with(@review, status: 201, default_template: :show)
          else
            invalid_resource!(@review)
          end
        end

        private
        def find_product
          @product = Spree::Product.find(params[:product_id])
          authorize! :read, @product
        end

        def permitted_review_attributes
          [:rating, :title, :review, :name, :show_identifier]
        end

        def review_params
          params.require(:review).permit(permitted_review_attributes)
        end
      end
    end
  end
end
