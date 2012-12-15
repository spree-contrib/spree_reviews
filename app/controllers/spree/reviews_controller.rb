class Spree::ReviewsController < Spree::StoreController
  helper Spree::BaseHelper
  before_filter :load_product, :only => [:index, :new, :create]
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  def index
    @approved_reviews = Spree::Review.approved.find_all_by_product_id(@product.id)
  end

  def new
    @review = Spree::Review.new(:product => @product)
    authorize! :create, @review
  end

  # save if all ok
  def create
    params[:review][:rating].sub!(/\s*[^0-9]*$/,'') unless params[:review][:rating].blank?

    @review = Spree::Review.new(params[:review])
    @review.product = @product
    @review.user = spree_current_user if user_signed_in?
    @review.ip_address = request.remote_ip
    @review.locale = I18n.locale.to_s if Spree::Reviews::Config[:track_locale]

    authorize! :create, @review

    if @review.save
      flash[:notice] = t('review_successfully_submitted')
      redirect_to (product_path(@product))
    else
      render :action => "new"
    end
  end

  def terms
  end

  private

  def load_product
    @product = Spree::Product.find_by_permalink!(params[:product_id])
  end

end
