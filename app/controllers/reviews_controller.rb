class ReviewsController < Spree::BaseController
  helper Spree::BaseHelper
  before_filter :load_product

  def index
    @approved_reviews = Review.approved.find_all_by_product_id(@product.id) 
  end

  def new
    @review = Review.new :product => @product
  end

  # save if all ok
  def create
    params[:review][:rating].sub!(/\s*stars/,'') unless params[:review][:rating].blank?

    @review = Review.new
    @review.product = @product
    @review.user = current_user if user_signed_in?
    if @review.update_attributes(params[:review])
      flash[:notice] = t('review_successfully_submitted')
      redirect_to (product_path(@product))
    else
      # flash[:notice] = 'There was a problem in the submitted review'
      render :action => "new" 
    end
  end
  
  def terms
  end
  
  private
    
    def load_product
      @product = Product.find_by_permalink params[:product_id]
      render_404(ActiveRecord::RecordNotFound, 'Product not found') unless @product
    end
end
