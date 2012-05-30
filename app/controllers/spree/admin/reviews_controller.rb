class Spree::Admin::ReviewsController < Spree::Admin::BaseController
  helper Spree::Admin::NavigationHelper

  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    redirect_to spree.admin_reviews_url, notice: 'Review was successfully deleted.'
  end

  ## Toggle a review's state between published and unpublished
  def toggle_published
    @review = Review.find(params[:review_id])
    @review.toggle_published

    redirect_to :back
  end
end
