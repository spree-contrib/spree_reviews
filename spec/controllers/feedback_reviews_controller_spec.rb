require 'spec_helper'

describe Spree::FeedbackReviewsController do
  let(:token) { 'some_token' }
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  let(:review) { create(:review, product: product, approved: true)}

  before do
    controller.stub :spree_current_user => user
    controller.stub :spree_user_signed_in? => true
  end

  context '#create' do
    context 'for a valid review' do
      context 'with valid params' do
        it 'creates a new feedback review' do
          rating = 4
          comment = Faker::Lorem.paragraphs(3).join("\n")
          expect {
            spree_post :create, { review_id: review.id,
                                  feedback_review: { comment: comment,
                                                     rating: rating },
                                  format: :js },
                                { access_token: token }
            response.status.should eq(200)
            response.should render_template(:create)
          }.to change(Spree::Review, :count).by(1)
          feedback_review = Spree::FeedbackReview.last
          feedback_review.comment.should eq(comment)
          feedback_review.review.should eq(review)
          feedback_review.rating.should eq(rating)
          feedback_review.user.should eq(user)

        end
      end
    end
  end
end
