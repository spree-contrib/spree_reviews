RSpec.describe Spree::Review, type: :model do
  context 'validations' do
    it 'validates by default' do
      expect(build(:review)).to be_valid
    end

    it 'does not validate with a nil review' do
      expect(build(:review, review: nil)).not_to be_valid
    end

    context 'rating' do
      it 'does not validate when no rating is specified' do
        expect(build(:review, rating: nil)).not_to be_valid
      end

      it 'does not validate when the rating is not a number' do
        expect(build(:review, rating: 'not_a_number')).not_to be_valid
      end

      it 'does not validate when the rating is a float' do
        expect(build(:review, rating: 2.718)).not_to be_valid
      end

      it 'does not validate when the rating is less than 1' do
        expect(build(:review, rating: 0)).not_to be_valid
        expect(build(:review, rating: -5)).not_to be_valid
      end

      it 'does not validate when the rating is greater than 5' do
        expect(build(:review, rating: 6)).not_to be_valid
        expect(build(:review, rating: 8)).not_to be_valid
      end

      (1..5).each do |i|
        it "validates when the rating is #{i}" do
          expect(build(:review, rating: i)).to be_valid
        end
      end
    end

    context 'review body' do
      it 'is not be valid without a body' do
        expect(build(:review, review: nil)).not_to be_valid
      end
    end
  end

  context 'scopes' do
    context 'most_recent_first' do
      let!(:review_1) { create(:review, created_at: 10.days.ago) }
      let!(:review_2) { create(:review, created_at: 2.days.ago) }
      let!(:review_3) { create(:review, created_at: 5.days.ago) }

      it 'properly runs most_recent_first queries' do
        expect(described_class.most_recent_first.to_a).to eq([review_2, review_3, review_1])
      end

      it 'defaults to most_recent_first queries' do
        expect(described_class.all.to_a).to eq([review_2, review_3, review_1])
      end
    end

    context 'oldest_first' do
      let!(:review_1) { create(:review, created_at: 10.days.ago) }
      let!(:review_2) { create(:review, created_at: 2.days.ago) }
      let!(:review_3) { create(:review, created_at: 5.days.ago) }
      let!(:review_4) { create(:review, created_at: 1.days.ago) }

      before do
        reset_spree_preferences
      end

      it 'properly runs oldest_first queries' do
        expect(described_class.oldest_first.to_a).to eq([review_1, review_3, review_2, review_4])
      end

      it 'uses oldest_first for preview' do
        reset_spree_preferences
        expect(described_class.preview.to_a).to eq([review_1, review_3, review_2])
      end
    end

    context 'localized' do
      let!(:en_review_1) { create(:review, locale: 'en', created_at: 10.days.ago) }
      let!(:en_review_2) { create(:review, locale: 'en', created_at: 2.days.ago) }
      let!(:en_review_3) { create(:review, locale: 'en', created_at: 5.days.ago) }

      let!(:es_review_1) { create(:review, locale: 'es', created_at: 10.days.ago) }
      let!(:fr_review_1) { create(:review, locale: 'fr', created_at: 10.days.ago) }

      it 'properly runs localized queries' do
        expect(described_class.localized('en').to_a).to eq([en_review_2, en_review_3, en_review_1])
        expect(described_class.localized('es').to_a).to eq([es_review_1])
        expect(described_class.localized('fr').to_a).to eq([fr_review_1])
      end
    end

    context 'approved / not_approved / default_approval_filter' do
      let!(:approved_review_1) { create(:review, approved: true, created_at: 10.days.ago) }
      let!(:approved_review_2) { create(:review, approved: true, created_at: 2.days.ago) }
      let!(:approved_review_3) { create(:review, approved: true, created_at: 5.days.ago) }

      let!(:unapproved_review_1) { create(:review, approved: false, created_at: 7.days.ago) }
      let!(:unapproved_review_2) { create(:review, approved: false, created_at: 1.days.ago) }

      it 'properly runs approved and unapproved queries' do
        expected = [
          approved_review_2,
          approved_review_3,
          approved_review_1
        ]
        expect(described_class.approved.to_a).to match_array expected

        expected = [
          unapproved_review_2,
          unapproved_review_1
        ]
        expect(described_class.not_approved.to_a).to match_array expected

        Spree::Reviews::Config[:include_unapproved_reviews] = true
        expected = [
          unapproved_review_2,
          approved_review_2,
          approved_review_3,
          unapproved_review_1,
          approved_review_1
        ]
        expect(described_class.default_approval_filter.to_a).to match_array expected

        Spree::Reviews::Config[:include_unapproved_reviews] = false
        expected = [
          approved_review_2,
          approved_review_3,
          approved_review_1
        ]
        expect(Spree::Review.default_approval_filter.to_a).to match_array expected
      end
    end
  end

  describe '.recalculate_product_rating' do
    let(:product) { create(:product) }
    let!(:review) { create(:review, product: product) }

    before { product.reviews << review }

    it 'if approved' do
      expect(review).to receive(:recalculate_product_rating)
      review.approved = true
      review.save!
    end

    it 'if not approved' do
      expect(review).not_to receive(:recalculate_product_rating)
      review.save!
    end

    it 'updates the product average rating' do
      expect(review.product).to receive(:recalculate_rating)
      review.approved = true
      review.save!
    end
  end

  describe '.feedback_stars' do
    let!(:user) { create(:user) }
    let!(:review) { create(:review) }

    before do
      3.times do |i|
        f = Spree::FeedbackReview.new
        f.user = user
        f.review = review
        f.rating = (i + 1)
        f.save!
      end
    end

    it 'returns the average rating from feedback reviews' do
      expect(review.feedback_stars).to be(2)
    end
  end
end
