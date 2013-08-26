require 'spec_helper'

describe Spree::Review do

  context 'validations' do
    it 'validates by default' do
      build(:review).should be_valid
    end

    it 'validates with a nil user' do
      build(:review, user: nil).should be_valid
    end

    it 'does not validate with a nil review' do
      build(:review, review: nil).should_not be_valid
    end

    context 'rating' do
      it 'does not validate when no rating is specified' do
        build(:review, rating: nil).should_not be_valid
      end

      it 'does not validate when the rating is not a number' do
        build(:review, rating: 'not_a_number').should_not be_valid
      end

      it 'does not validate when the rating is a float' do
        build(:review, rating: 2.718).should_not be_valid
      end

      it 'does not validate when the rating is less than 1' do
        build(:review, rating: 0).should_not be_valid
        build(:review, rating: -5).should_not be_valid
      end

      it 'does not validate when the rating is greater than 5' do
        build(:review, rating: 6).should_not be_valid
        build(:review, rating: 8).should_not be_valid
      end

      (1..5).each do |i|
        it "validates when the rating is #{i}" do
          build(:review, rating: i).should be_valid
        end
      end
    end

    context 'review body' do
      it 'should not be valid without a body' do
        build(:review, review: nil).should_not be_valid
      end
    end
  end

  context 'scopes' do
    context 'most_recent_first' do
      let!(:review_1) { create(:review, created_at: 10.days.ago) }
      let!(:review_2) { create(:review, created_at: 2.days.ago) }
      let!(:review_3) { create(:review, created_at: 5.days.ago) }

      it 'properly runs most_recent_first queries' do
        Spree::Review.most_recent_first.to_a.should eq([review_2, review_3, review_1])
      end

      it 'defaults to most_recent_first queries' do
        Spree::Review.all.to_a.should eq([review_2, review_3, review_1])
      end
    end

    context 'oldest_first' do
      let!(:review_1) { create(:review, created_at: 10.days.ago) }
      let!(:review_2) { create(:review, created_at: 2.days.ago) }
      let!(:review_3) { create(:review, created_at: 5.days.ago) }
      let!(:review_4) { create(:review, created_at: 1.days.ago) }

      it 'properly runs oldest_first queries' do
        Spree::Review.oldest_first.to_a.should eq([review_1, review_3, review_2, review_4])
      end

      it 'uses oldest_first for preview' do
        Spree::ReviewsConfiguration.new.reset
        Spree::Review.preview.to_a.should eq([review_1, review_3, review_2])
      end
    end

    context 'localized' do
      let!(:en_review_1) { create(:review, locale: 'en', created_at: 10.days.ago) }
      let!(:en_review_2) { create(:review, locale: 'en', created_at: 2.days.ago) }
      let!(:en_review_3) { create(:review, locale: 'en', created_at: 5.days.ago) }

      let!(:es_review_1) { create(:review, locale: 'es', created_at: 10.days.ago) }
      let!(:fr_review_1) { create(:review, locale: 'fr', created_at: 10.days.ago) }

      it 'properly runs localized queries' do
        Spree::Review.localized('en').to_a.should eq([en_review_2, en_review_3, en_review_1])
        Spree::Review.localized('es').to_a.should eq([es_review_1])
        Spree::Review.localized('fr').to_a.should eq([fr_review_1])
      end
    end

    context 'approved / not_approved / default_approval_filter' do
      let!(:approved_review_1) { create(:review, approved: true, created_at: 10.days.ago) }
      let!(:approved_review_2) { create(:review, approved: true, created_at: 2.days.ago) }
      let!(:approved_review_3) { create(:review, approved: true, created_at: 5.days.ago) }

      let!(:unapproved_review_1) { create(:review, approved: false, created_at: 7.days.ago) }
      let!(:unapproved_review_2) { create(:review, approved: false, created_at: 1.days.ago) }

      it 'properly runs approved and unapproved queries' do
        Spree::Review.approved.to_a.should eq([approved_review_2, approved_review_3, approved_review_1])
        Spree::Review.not_approved.to_a.should eq([unapproved_review_2, unapproved_review_1])

        Spree::Reviews::Config[:include_unapproved_reviews] = true
        Spree::Review.default_approval_filter.to_a.should eq([unapproved_review_2, 
                                                              approved_review_2, 
                                                              approved_review_3, 
                                                              unapproved_review_1, 
                                                              approved_review_1])

        Spree::Reviews::Config[:include_unapproved_reviews] = false
        Spree::Review.default_approval_filter.to_a.should eq([approved_review_2, approved_review_3, approved_review_1])
      end
    end
  end

  context "#recalculate_product_rating" do
    let(:product) { create(:product) }
    let!(:review) { create(:review, product: product) }

    before { product.reviews << review }

    it "if approved" do
      review.should_receive(:recalculate_product_rating)
      review.approved = true
      review.save!
    end

    it "if not approved" do
      review.should_not_receive(:recalculate_product_rating)
      review.save!
    end

    it "updates the product average rating" do
      review.product.should_receive(:recalculate_rating)
      review.approved = true
      review.save!
    end
  end

  context "#feedback_stars" do
    let!(:review) { create(:review) }
    before do
      3.times do |i|
        f = Spree::FeedbackReview.new
        f.review = review
        f.rating = (i+1)
        f.save
      end
    end

    it "should return the average rating from feedback reviews" do
      review.feedback_stars.should == 2
    end
  end
end
