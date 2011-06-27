class Admin::ReviewsController < Admin::ResourceController
  helper :reviews

  def index
    @unapproved_reviews = Review.not_approved.find(:all, :order => "created_at DESC")
    @approved_reviews   = Review.approved.find(:all, :order => "created_at DESC")
  end

  def approve
    r = Review.find(params[:id])

    if r.update_attribute(:approved, true)
       r.product.recalculate_rating
       flash[:notice] = t("info_approve_review")
    else
       flash[:error] = t("error_approve_review")
    end
    redirect_to admin_reviews_path
  end
end
