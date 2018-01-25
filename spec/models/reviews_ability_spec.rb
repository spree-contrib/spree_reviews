require 'cancan/matchers'

RSpec.describe Spree::ReviewsAbility, type: :model do
  context '.allow_anonymous_reviews?' do
    it 'depends on Spree::Reviews::Config[:require_login]' do
      Spree::Reviews::Config[:require_login] = false
      expect(described_class.allow_anonymous_reviews?).to be(true)
      Spree::Reviews::Config[:require_login] = true
      expect(described_class.allow_anonymous_reviews?).to be(false)
    end
  end

  context 'permissions' do
    let(:user_without_email) { double(:user, email: nil) }
    let(:user_with_email) { double(:user, email: 'a@b.com') }

    context 'when anonymous reviews are allowed' do
      before do
        Spree::Reviews::Config[:require_login] = false
      end

      it 'lets anyone create a review or feedback review' do
        [user_without_email, user_with_email].each do |u|
          expect(described_class.new(u)).to be_able_to(:create, Spree::Review.new)
          expect(described_class.new(u)).to be_able_to(:create, Spree::FeedbackReview.new)
        end
      end
    end

    context 'when anonymous reviews are not allowed' do
      before do
        Spree::Reviews::Config[:require_login] = true
      end

      it 'only allows users with an email to create a review or feedback review' do
        expect(described_class.new(user_without_email)).not_to be_able_to(:create, Spree::Review.new)
        expect(described_class.new(user_without_email)).not_to be_able_to(:create, Spree::FeedbackReview.new)
        expect(described_class.new(user_with_email)).to be_able_to(:create, Spree::Review.new)
        expect(described_class.new(user_with_email)).to be_able_to(:create, Spree::FeedbackReview.new)
      end
    end
  end

  describe 'access review settings' do
    subject { described_class.new(user) }

    context 'when is ordinal user' do
      let(:user) { build_stubbed(:user) }

      it { is_expected.not_to be_able_to(:manage, Spree::ReviewSetting) }
    end

    context 'when is admin' do
      let(:user) { build_stubbed(:admin_user) }

      it { is_expected.to be_able_to(:manage, Spree::ReviewSetting) }
    end
  end
end
