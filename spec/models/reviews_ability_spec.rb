require 'spec_helper'

require "cancan/matchers"

describe Spree::ReviewsAbility do
  context '.allow_anonymous_reviews?' do
    it 'should depend on Spree::Reviews::Config[:require_login]' do
      Spree::Reviews::Config[:require_login] = false
      Spree::ReviewsAbility.allow_anonymous_reviews?.should be_true
      Spree::Reviews::Config[:require_login] = true
      Spree::ReviewsAbility.allow_anonymous_reviews?.should be_false
    end
  end

  context 'permissions' do
    let(:anonymous_user) { double(:user, anonymous?: true, email: 'a@b.com') }
    let(:user_without_email) { double(:user, anonymous?: false, email: nil) }
    let(:user_with_email) { double(:user, anonymous?: false, email: 'a@b.com') }

    context 'when anonymous reviews are allowed' do
      before do
        Spree::Reviews::Config[:require_login] = false
      end

      it 'lets anyone create a review or feedback review' do
        [anonymous_user, user_without_email, user_with_email].each do |u|
          Spree::ReviewsAbility.new(u).should be_able_to(:create, Spree::Review.new)
          Spree::ReviewsAbility.new(u).should be_able_to(:create, Spree::FeedbackReview.new)
        end
      end
    end

    context 'when anonymous reviews are not allowed' do
      before do
        Spree::Reviews::Config[:require_login] = true
      end

      it 'only allows non-anonymous users with an email to create a review or feedback review' do
        [anonymous_user, user_without_email].each do |u|
          Spree::ReviewsAbility.new(u).should_not be_able_to(:create, Spree::Review.new)
          Spree::ReviewsAbility.new(u).should_not be_able_to(:create, Spree::FeedbackReview.new)
        end
        Spree::ReviewsAbility.new(user_with_email).should be_able_to(:create, Spree::Review.new)
        Spree::ReviewsAbility.new(user_with_email).should be_able_to(:create, Spree::FeedbackReview.new)
      end
    end
  end
end