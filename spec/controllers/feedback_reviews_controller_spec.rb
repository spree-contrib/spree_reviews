require 'spec_helper'

describe Spree::FeedbackReviewsController do
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  let(:review) { create(:review, user: user) }
  let(:valid_attributes) do
    { review_id: review.id,
      user_id: user.id,
      feedback_review: {
        rating: '4 stars',
        comment: 'some comment'
      }}
  end

  before do
    controller.stub spree_current_user: user
    controller.stub spree_user_signed_in?: true
    request.env['HTTP_REFERER'] = '/'
  end

  describe '#create' do
    it 'creates a feedback-review' do
      expect {
        spree_post :create, valid_attributes
      }.to change(Spree::FeedbackReview, :count).from(0).to(1)
    end

    it 'redirects back to the calling page' do
      spree_post :create, valid_attributes
      response.should redirect_to '/'
    end

    it 'sets locale on feedback-review if required by config' do
      Spree::Reviews::Config.preferred_track_locale = true
      spree_post :create, valid_attributes
      assigns[:review].locale.should eq I18n.locale.to_s
    end

    it 'fails when user is not authorized' do
      controller.stub(:authorize!) { raise }
      expect {
        spree_post :create, valid_attributes
      }.to raise_error
    end

    it 'removes all non-numbers from ratings parameter' do
      spree_post :create, valid_attributes
      controller.params[:feedback_review][:rating].should eq '4'
    end

    it 'do not create feedback-review if review doesnt exist' do
      expect {
        spree_post :create, valid_attributes.merge!({review_id: nil})
      }.to raise_error
    end
  end
end