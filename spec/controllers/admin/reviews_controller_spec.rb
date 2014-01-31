require 'spec_helper'

describe Spree::Admin::ReviewsController do
  stub_authorization!

  let(:product) { create(:product) }
  let(:review) { create(:review, approved: false) }

  before do
    user = create(:admin_user)
    controller.stub(try_spree_current_user: user)
  end

  context '#index' do
    it 'list reviews' do
      reviews = [
        create(:review, product: product),
        create(:review, product: product)
      ]
      spree_get :index, product_id: product.permalink
      assigns[:reviews].should =~ reviews
    end
  end

  context '#approve' do
    it 'show notice message when approved' do
      review.update_attribute(:approved, true)
      spree_get :approve, id: review.id
      response.should redirect_to spree.admin_reviews_path
      flash[:notice].should eq Spree.t(:info_approve_review)
    end

    it 'show error message when not approved' do
      Spree::Review.any_instance.stub(:update_attribute).and_return(false)
      spree_get :approve, id: review.id
      flash[:error].should eq Spree.t(:error_approve_review)
    end
  end

  context '#edit' do
    specify do
      spree_get :edit, id: review.id
      response.status.should eq(200)
    end

    context 'when product is nil' do
      before do
        review.product = nil
        review.save!
      end

      it 'flash error' do
        spree_get :edit, id: review.id
        flash[:error].should eq Spree.t(:error_no_product)
      end

      it 'redirect to admin-reviews page' do
        spree_get :edit, id: review.id
        response.should redirect_to spree.admin_reviews_path
      end
    end
  end
end