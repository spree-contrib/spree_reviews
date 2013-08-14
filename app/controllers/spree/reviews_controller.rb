class Spree::ReviewsController < Spree::StoreController
  helper Spree::BaseHelper
  before_filter :load_reviewable, :only => [:index, :new, :create]
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  def index
    @approved_reviews = @reviewable.reviews.approved
  end

  def new
    @review = Spree::Review.new(:reviewable => @reviewable)
    authorize! :create, @review
  end

  # save if all ok
  def create
    params[:review][:rating].sub!(/\s*[^0-9]*$/,'') unless params[:review][:rating].blank?

    @review = @reviewable.reviews.build(params[:review])
    @review.user = spree_current_user if spree_user_signed_in?
    @review.ip_address = request.remote_ip
    @review.locale = I18n.locale.to_s if Spree::Reviews::Config[:track_locale]

    authorize! :create, @review

    if @review.save
      flash[:notice] = t('review_successfully_submitted')
      redirect_to_reviewable
    else
      render :action => "new"
    end
  end

  def terms
  end

  private

  def load_reviewable
    if params[:product_id]
      @reviewable = Spree::Product.find_by_permalink!(params[:product_id])
    else
      @reviewable = Spree::Site.instance
    end
  end

  def redirect_to_reviewable
    if @reviewable.is_a?(Spree::Product)
      redirect_to (product_path(@reviewable))
    else
      redirect_to reviews_path
    end
  end

end
