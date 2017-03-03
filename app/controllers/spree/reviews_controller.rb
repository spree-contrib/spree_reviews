class Spree::ReviewsController < Spree::StoreController
  helper Spree::BaseHelper
  before_action :load_product, only: [:index, :new, :create, :edit, :update]
  before_action :find_review_for_user, only: [:edit, :update]
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def index
    @approved_reviews = Spree::Review.approved.where(product: @product)
  end

  def new
    @review = Spree::Review.new(product: @product)
    authorize! :create, @review
    redirect_to edit_product_review_path(@product, id: find_review_for_user) unless @product.not_reviewed_by? spree_current_user
  end

  def edit
    authorize! :edit, @review
  end

  def update
    authorize! :update, @review
    params[:review][:rating].sub!(/\s*[^0-9]*\z/, '') unless params[:review][:rating].blank?
    if @review.update(review_params)
      @review.update_attributes(approved: false)
      redirect_to spree.product_path(@review.product)
    else
      render 'edit'
    end
  end

  # save if all ok
  def create
    params[:review][:rating].sub!(/\s*[^0-9]*\z/, '') unless params[:review][:rating].blank?

    @review = Spree::Review.new(review_params)
    @review.product = @product
    @review.user = spree_current_user if spree_user_signed_in?
    @review.ip_address = request.remote_ip
    @review.locale = I18n.locale.to_s if Spree::Reviews::Config[:track_locale]

    authorize! :create, @review
    if @review.save
      flash[:notice] = Spree.t(:review_successfully_submitted)
      redirect_to spree.product_path(@product)
    else
      render :new
    end
  end

  private

  def find_review_for_user
    @review = @product.review_for_current_user(spree_current_user)
  end

  def load_product
    @product = Spree::Product.friendly.find(params[:product_id])
  end

  def permitted_review_attributes
    [:rating, :title, :review, :name, :show_identifier]
  end

  def review_params
    params.require(:review).permit(permitted_review_attributes)
  end
end
