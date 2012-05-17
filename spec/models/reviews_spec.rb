require File.dirname(__FILE__) + '/../spec_helper'

describe Spree::Review do
  before(:each) do
    user = FactoryGirl.create(:user)
    @review = Spree::Review.new(:name => "blah", :rating => "2", :review => "great", :user => user)
  end

  context "creating a new wishlist" do
    it "is valid with valid attributes" do
      @review.should be_valid
    end

    it "is not valid without a rating" do
      @review.rating = nil
      @review.should_not be_valid
    end

    it "is not valid unless the rating is an integer" do
      @review.rating = 2.0
      @review.should_not be_valid
    end

    it "is not valid without a review body" do
      @review.review = nil
      @review.should_not be_valid
    end
  end

  context "#recalculate_product_rating" do
    let(:product) { FactoryGirl.create(:product) }
    before { product.reviews << @review }

    it "if approved" do
      @review.should_receive(:recalculate_product_rating)
      @review.approved = true
      @review.save!
    end

    it "if not approved" do
      @review.should_not_receive(:recalculate_product_rating)
      @review.save!
    end

    it "updates the product average rating" do
      @review.approved = true
      @review.save!
      @review.product.reload.avg_rating.should == 2

      @review.destroy
      product.reload.avg_rating.should == 0
    end
  end

  context "#feedback_stars" do
    before(:each) do
      @review.save
      3.times do |i|
        f = Spree::FeedbackReview.new
        f.review = @review
        f.rating = (i+1)
        f.save
      end
    end

    it "should return the average rating from feedback reviews" do
      @review.feedback_stars.should == 2
    end
  end
end
