class ReviewsController < Spree::BaseController
  helper Spree::BaseHelper
  require_role [:user,:admin], :only => [:new,:create]

  def index
    @product = Product.find_by_permalink params[:product_id]
    @approved_reviews = Review.approved.find_all_by_product_id(@product.id) 
  end

  def new
    @product = Product.find_by_permalink params[:product_id] 
    @review = Review.new :product => @product
  end

  # save if all ok
  def create
    @product = Product.find_by_permalink params[:product_id]
    params[:review][:rating].sub!(/\s*stars/,'') unless params[:review][:rating].blank?

    @review = Review.new :product => @product
    if @review.update_attributes(params[:review]) 
      flash[:notice] = 'Review was successfully submitted.'
      redirect_to (product_path(@product))
    else
      # flash[:notice] = 'There was a problem in the submitted review'
      render :action => "new" 
    end
  end
end
