require 'spec_helper'

describe "Review Admin", :js => true do
  stub_authorization!

  before do
    @review = FactoryGirl.create :review
    FactoryGirl.create :review
  end

  let(:review) { @review }

  it "should list out the reviews" do
    visit spree.admin_reviews_path
    page.should have_content(review.title)
  end

  it "should be able to approve the reviews" do
    visit spree.admin_reviews_path
    page.should have_content(@review.title)
    within("tr#review_#{@review.id}") { click_link "Approve" }
    page.should_not have_content(@review.title)
  end

  it "should be able to edit the reviews" do
    visit spree.admin_reviews_path
    page.should have_content(@review.title)
    within("tr#review_#{@review.id}") { click_link "Edit" }
    page.should have_content('Editing')
    page.should have_content(@review.title)
  end
end