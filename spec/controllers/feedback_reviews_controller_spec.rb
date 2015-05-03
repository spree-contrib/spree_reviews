RSpec.describe Spree::FeedbackReviewsController, type: :controller do
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  let(:review) { create(:review, user: user) }
  let(:valid_attributes) do
    {
      review_id: review.id,
      user_id: user.id,
      feedback_review: {
        rating: '4 stars',
        comment: 'some comment'
      }
    }
  end

  before do
    allow(controller).to receive(:spree_current_user).and_return(user)
    allow(controller).to receive(:spree_user_signed_in?).and_return(true)
    request.env['HTTP_REFERER'] = '/'
  end

  describe '#create' do
    it 'creates a new feedback review' do
      rating = 4
      comment = generate(:random_description)
      expect {
        spree_post(
          :create,
          review_id: review.id,
          format: :js,
          feedback_review: {
            comment: comment,
            rating: rating
          }
        )
        expect(response.status).to be(200)
        expect(response).to render_template(:create)
      }.to change(Spree::Review, :count).by(1)

      feedback_review = Spree::FeedbackReview.last

      expect(feedback_review.comment).to eq(comment)
      expect(feedback_review.review).to eq(review)
      expect(feedback_review.rating).to eq(rating)
      expect(feedback_review.user).to eq(user)
    end

    it 'redirects back to the calling page' do
      spree_post :create, valid_attributes
      expect(response).to redirect_to('/')
    end

    it 'sets locale on feedback-review if required by config' do
      Spree::Reviews::Config.preferred_track_locale = true
      spree_post :create, valid_attributes
      expect(assigns[:review].locale).to eq I18n.locale.to_s
    end

    it 'fails when user is not authorized' do
      allow(controller).to receive(:authorize!) { raise }
      expect {
        spree_post :create, valid_attributes
      }.to raise_error
    end

    it 'removes all non-numbers from ratings parameter' do
      spree_post :create, valid_attributes
      expect(controller.params[:feedback_review][:rating]).to eq('4')
    end

    it 'does not create feedback-review if review doesnt exist' do
      expect {
        spree_post :create, valid_attributes.merge!(review_id: nil)
      }.to raise_error
    end
  end
end
