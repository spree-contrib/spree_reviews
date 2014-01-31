require 'spec_helper'

describe Spree::Admin::ReviewsController do
  stub_authorization!

  let(:product) { create(:product) }

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
end