class ReviewsController < ApplicationController
  def create
    @product = Spree::Product.find_by_permalink(params[:product_id])
    @review = @product.reviews.build(params[:review])
    @commenter = BareNaked::Commenter.find_or_create_by_email(params[:commenter][:email])
    @commenter.update_attributes(name: params[:commenter][:name])
    @review.commenter = @commenter
    if @review.save
      if @commenter.state == 'unverified'
        BareNaked::CommenterMailer.verify(@commenter).deliver
        flash[:notice] == 'You have been sent an email with a link to verify your email address, please check your inbox. Once you have verified your email address, your review will be shown.'
      end
      redirect_to spree.product_path(@review.product)
    else
      redirect_to spree.product_path(@review.product), alert: 'Something went wrong.'
    end
  end
end