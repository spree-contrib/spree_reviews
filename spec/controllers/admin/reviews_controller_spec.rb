RSpec.describe Spree::Admin::ReviewsController, type: :controller do
  stub_authorization!

  let(:product) { create(:product) }
  let(:review) { create(:review, approved: false) }

  before do
    user = create(:admin_user)
    allow(controller).to receive(:try_spree_current_user).and_return(user)
  end

  describe '#index' do
    it 'lists reviews' do
      reviews = [
        create(:review),
        create(:review)
      ]
      get :index, params: { product_id: product.slug }
      expect(assigns[:reviews]).to match_array(reviews)
    end
  end

  describe '#approve' do
    it 'shows notice message when approved' do
      review.update_attribute(:approved, true)
      get :approve, params: { id: review.id }
      expect(response).to redirect_to spree.admin_reviews_path
      expect(flash[:notice]).to eq Spree.t(:info_approve_review)
    end

    it 'shows error message when not approved' do
      allow_any_instance_of(Spree::Review).to receive(:update_attribute).and_return(false)
      get :approve, params: { id: review.id }
      expect(flash[:error]).to eq Spree.t(:error_approve_review)
    end
  end

  describe '#edit' do
    it 'returns http success' do
      get :edit, params: { id: review.id }
      expect(response.status).to be(200)
    end

    context 'when product is nil' do
      before do
        review.update_attribute(:product_id, nil)

        review.save
      end

      it 'flashes error' do
        get :edit, params: { id: review.id }
        expect(flash[:error]).to eq Spree.t(:error_no_product)
      end

      it 'redirects to admin-reviews page' do
        get :edit, params: { id: review.id }
        expect(response).to redirect_to spree.admin_reviews_path
      end
    end
  end
end
