require 'spec_helper'

describe "Review Admin", :js => true do
  stub_authorization!
  let!(:review) { create(:review) }

  before do
    visit spree.admin_reviews_path
  end

  it "should list out the reviews" do
    page.should have_content(review.title)
  end

  it "should be able to approve the reviews" do
    review.approved.should be_false
    page.find("tr#review_#{review.id} .approve").trigger(:click)
    expect{ review.reload.approved }.to be_true
  end

  it "should be able to edit the reviews" do
    page.should have_content(review.title)
    page.find("tr#review_#{review.id} .edit").trigger(:click)
    page.should have_content('Editing')
    page.should have_content(review.title)
  end
end
