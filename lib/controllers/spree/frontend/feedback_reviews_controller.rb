module Spree
  class FeedbackReviewsController < Spree::StoreController
    helper Spree::BaseHelper

    before_action :sanitize_rating, only: :create
    before_action :load_review, only: :create

    def create
      if @review.present?
        @feedback_review = @review.feedback_reviews.new(feedback_review_params)
        @feedback_review.user = spree_current_user
        @feedback_review.locale = I18n.locale.to_s if Spree::Reviews::Config[:track_locale]
        authorize! :create, @feedback_review
        @feedback_review.save
      end

      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path) }
        format.js { render action: :create }
      end
    end

    protected

    def load_review
      @review ||= Spree::Review.find_by_id!(params[:review_id])
    end

    def permitted_feedback_review_attributes
      [:rating, :comment]
    end

    def feedback_review_params
      params.require(:feedback_review).permit(permitted_feedback_review_attributes)
    end

    def sanitize_rating
      params[:feedback_review][:rating].to_s.sub!(/\s*[^0-9]*\z/, '') unless params[:feedback_review] && params[:feedback_review][:rating].blank?
    end

    def redirect_back(fallback_location:)
      if Rails.gem_version >= Gem::Version.new('5.x')
        super
      else
        redirect_to :back
      end
    end
  end
end
