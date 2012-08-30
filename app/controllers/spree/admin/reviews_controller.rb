class Spree::Admin::ReviewsController < Spree::Admin::ResourceController
  helper Spree::ReviewsHelper

  def index
    @reviews = collection
  end

  def approve
    r = Spree::Review.find(params[:id])

    if r.update_attribute(:approved, true)
       flash[:notice] = t("info_approve_review")
    else
       flash[:error] = t("error_approve_review")
    end
    redirect_to admin_reviews_path
  end

  def edit
    if @review.product.nil?
      flash[:error] = t("error_no_product")
      redirect_to admin_reviews_path and return
    end
  end
private

  def collection
    params[:q] ||= {}
    params[:q][:approved_eq] = false if params[:q][:approved_eq].nil?

    @search = Spree::Review.ransack(params[:q])
    @collection = @search.result.includes([:product, :user, :feedback_reviews]).page(params[:page]).per(params[:per_page])
  end
end
