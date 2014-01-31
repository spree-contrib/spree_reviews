require 'spec_helper'

feature 'Review Admin', js: true do
  stub_authorization!

  given!(:review) { create(:review) }

  context 'index' do
    background do
      visit spree.admin_reviews_path
    end

    scenario 'list reviews' do
      expect(page).to have_text review.product.name
    end

    scenario 'approve reviews' do
      expect(review.approved).to be_false
      within("tr#review_#{review.id}") do
        find('.approve').click
      end
      expect {
        review.reload.approved
      }.to be_true
    end

    scenario 'edit reviews' do
      expect(page).to have_text review.product.name
      within("tr#review_#{review.id}") do
        find('.edit').click
      end

      expect(page).to have_text 'Editing'
      expect(page).to have_text review.title
    end
  end
end
