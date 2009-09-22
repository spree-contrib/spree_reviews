class ReviewsController < Spree::BaseController
  helper Spree::BaseHelper
  require_role [:user,:admin], :only => [:submit,:create]

  def index
    if params[:product_id]
      @product = Product.find_by_id params[:product_id]
    else
      @product = Product.find_by_id params[:id]
    end
     @reviews=@product.reviews
  end

  # 
  def submit
    @review = Review.new :product_id => params[:id]
    @product = Product.find_by_id params[:id]
  end

  # save if all ok
  def create
    @review = Review.new :product_id => params[:id]
    @product = Product.find_by_id params[:review][:product_id]
    params[:review][:rating].sub!(/\s*stars/,'')

    if @review.update_attributes(params[:review]) 
      flash[:notice] = 'Review was successfully submitted.'
      redirect_to (product_path(@product))
    else
      # flash[:notice] = 'There was a problem in the submitted review'
      render :action => "submit" 
    end
  end
end
