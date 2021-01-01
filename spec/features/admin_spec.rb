require 'spec_helper'

describe 'Review Admin', :js do
  stub_authorization!

  let!(:review) { create(:review) }

  it 'index' do
    before do
      visit spree.admin_reviews_path
    end

    it 'list reviews' do
      expect(page).to have_text review.product.name
    end

    it 'approve reviews' do
      expect(review.approved).to be(false)
      within("tr#review_#{review.id}") do
        find('.approve').click
      end
      expect(review.reload.approved).to be(true)
    end

    it 'edit reviews' do
      expect(page).to have_text review.product.name
      within("tr#review_#{review.id}") do
        find('.action-edit').click
      end

      expect(page).to have_text 'Editing'
      expect(page).to have_text review.title
    end
  end
end
