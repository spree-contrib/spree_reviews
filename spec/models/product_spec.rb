require 'spec_helper'

describe Spree::Product do
  it { should respond_to(:avg_rating) }
  it { should respond_to(:reviews) }
  it { should respond_to(:stars) }

  context '#stars' do
    let(:product) { build(:product) }

    it 'rounds' do
      product.stub(:avg_rating).and_return(3.7)
      expect(product.stars).to eq(4)

      product.stub(:avg_rating).and_return(2.3)
      expect(product.stars).to eq(2)
    end


    it 'handles a nil value' do
      product.stub(:avg_rating).and_return(nil)
      expect {
        expect(product.stars).to eq(0)
      }.not_to raise_error
    end
  end

  context '#recalculate_rating' do
    let!(:product) { create(:product) }

    context 'when there are approved reviews' do
      let!(:approved_review_1) { create(:review, product: product, approved: true, rating: 4) }
      let!(:approved_review_2) { create(:review, product: product, approved: true, rating: 5) }
      let!(:unapproved_review_1) { create(:review, product: product, approved: false, rating: 4) }

      it "updates the product average rating and ignores unapproved reviews" do
        product.avg_rating = 0
        product.reviews_count = 0
        product.save!

        product.recalculate_rating
        product.avg_rating.should eq(4.5)
        product.reviews_count.should eq(2)
      end
    end

    context 'when no approved reviews' do
      let!(:unapproved_review_1) { create(:review, product: product, approved: false, rating: 4) }

      it "updates the product average rating and ignores unapproved reviews" do
        product.avg_rating = 3
        product.reviews_count = 20
        product.save!

        product.recalculate_rating
        product.avg_rating.should eq(0)
        product.reviews_count.should eq(0)
      end
    end

  end
end